Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B928B7B8095
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1kU-0001jx-Ut; Wed, 04 Oct 2023 09:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1kR-0001jj-Tl
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1kP-0004jR-GG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696425423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=G9NMXUiDTAkVk99euX9nqRBS92+ynXVoccMyztm33BnTxfKQictIAMW/+MbESBWPIYw2zy
 33W+BYvvB7ph1HN1K0r6DSGMBQNe5cX1DXv6jiNTkFfm3XDL9/6xAayUVxKddnzevtoLR0
 Mx+y7/Ng0hDPqDLIJkuXgNV9794vaIk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-kx2anxsyMvic7ni8G4GX7g-1; Wed, 04 Oct 2023 09:16:51 -0400
X-MC-Unique: kx2anxsyMvic7ni8G4GX7g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-533f8bc82a8so2081538a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696425410; x=1697030210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=joAeWbl1Re/caIFcLHCfxEsTnMLLCTjLZnfSqie5QssPQV4N+xZL+IPuBPKBtTLHhL
 UvDbOURBtPdvTR9NWcmN6Hus5Zqfsl1MgEyiO4StjZ3QkHF3RQoDii1DQZZGvdSuY7m0
 fQk/RsrMmhFNLzh3jSW9mS+DOV85W81ziPa0bO1MuUW0mpORtvet0Qtvu0wnXCkIOGiS
 JV+tOQPf9vq+gLWfv1JLOcA/iLGerfrRRXi4qGQXavtD/4FTTKPW6PQxIYLC4gOAiLLi
 09BEDNLdC5JwHH98tGMHx2OL5aHB+KckUbPwYe/HxREjEH71fSd8z3mBdW39qvjzZvd5
 v4Yw==
X-Gm-Message-State: AOJu0YxmXeFHWvH0m8gWGT1/RITy9ZVnbDE9yXUvOJaFdD0xlgUfRwoc
 eubANu9OT2s85ffZ9QSGYysUiDsadkpQl8/ZJZiueOtsDGAuz+NkIYCuRVoBx3rJHObSeLRh6DR
 GQFKUY2xyt5FlMFs=
X-Received: by 2002:a17:906:538a:b0:9b2:b269:d563 with SMTP id
 g10-20020a170906538a00b009b2b269d563mr2366811ejo.63.1696425410421; 
 Wed, 04 Oct 2023 06:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRScDOXUL9N1iVpcvFpxB/coY8daH/9ly+/D58Bqsc43jfQszjJUg4Ln8sIqP2ioF4h9iOcw==
X-Received: by 2002:a17:906:538a:b0:9b2:b269:d563 with SMTP id
 g10-20020a170906538a00b009b2b269d563mr2366794ejo.63.1696425410147; 
 Wed, 04 Oct 2023 06:16:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:2f4b:62da:3159:e077])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a1709064f0900b009b655c43710sm2787456eju.24.2023.10.04.06.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:16:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v2 0/2] sysemu/accel: Simplify sysemu/hvf.h
Date: Wed,  4 Oct 2023 15:16:48 +0200
Message-ID: <20231004131648.160432-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004092510.39498-1-philmd@linaro.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


