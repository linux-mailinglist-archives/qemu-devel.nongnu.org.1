Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 421217B80AC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1nf-0003ic-2J; Wed, 04 Oct 2023 09:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1nd-0003hG-AJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1na-00061b-TK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696425622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=FukOJoEU054c316r+A3f8OmTVK6mqPDuANghWMWHgyxEjpXhn75njNpP94OSUTSg5hVwPa
 RS3ofqZ630n7ZFIbsM4rdTmLeCakdzGdsL471YriKINhUlGC85RUkE0YcHwjmENQG+tx2Z
 xpSpFkLPVAlBQs7mUHo1PkXZh9NkQ14=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-RKdpzJbNPTSY0-o5OGwY-A-1; Wed, 04 Oct 2023 09:20:20 -0400
X-MC-Unique: RKdpzJbNPTSY0-o5OGwY-A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so184935366b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696425619; x=1697030419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=f7nZamCewRq9EounpKrrYgexHU0i3dBa2L4ot2L/+HlAPXTP8ifcMFDEDxQo8psOy0
 erfAUWw9PIlNuQfhPLFiskBa1GscoiQg4wUmQt6ZzvK3DuZtpJ3NQTqiXre5ZfkU1hNO
 6RkRoiEZe2nD7q57qigYZicgRjikP0et4cdnyuUuTQgdyhNjb2sQ42lSN2jFrjJV0TiZ
 aPxFfG2KLmF9PMASDfpAL5hne2oA9WtG43BcIATJLmgj59H0lRrT2gIeKZ+LJCg/N3Xz
 24bpABqIvTyAbKeykYQbVYDPI648PfhQ9sXMKlcKxR6dOHv2snChEpBLdlLkfrKHi1Iy
 1tMQ==
X-Gm-Message-State: AOJu0YxHa4DVZf4qF+dOHd6PK/x7/6sGFy/exCYXZ24i2CjGkC07YD6O
 pmVXREsi1wdBJ6sv0pHbQoq26mLY/2GVaL0EMe8RKnB5lE9nJscTyqDm+fG4NY6Au+tnnwuyAis
 KIB01XuOmeGMkSZQ=
X-Received: by 2002:a17:907:6c14:b0:9ae:588e:142 with SMTP id
 rl20-20020a1709076c1400b009ae588e0142mr1874251ejc.67.1696425619664; 
 Wed, 04 Oct 2023 06:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7twoX0IrFRKnVeuTHTo0/s8bsG7IxMJOotAEN++BJAnxA61mis/O8yWE9UyaGy0rZWZnOAg==
X-Received: by 2002:a17:907:6c14:b0:9ae:588e:142 with SMTP id
 rl20-20020a1709076c1400b009ae588e0142mr1874229ejc.67.1696425619330; 
 Wed, 04 Oct 2023 06:20:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:2f4b:62da:3159:e077])
 by smtp.gmail.com with ESMTPSA id
 um14-20020a170906cf8e00b0099297782aa9sm2778308ejb.49.2023.10.04.06.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:20:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 00/13] misc: Rename 'softmmu' -> 'system'
Date: Wed,  4 Oct 2023 15:20:17 +0200
Message-ID: <20231004132017.160874-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Queued, thanks.

Paolo


