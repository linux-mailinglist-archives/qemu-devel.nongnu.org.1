Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53202820422
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Dec 2023 10:34:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJVi4-0007vL-JD; Sat, 30 Dec 2023 04:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJVi3-0007vD-CI
 for qemu-devel@nongnu.org; Sat, 30 Dec 2023 04:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJVi1-00038l-Hx
 for qemu-devel@nongnu.org; Sat, 30 Dec 2023 04:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703928764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Op4+uPVXL5xFps1viUhlpcXvw1oM5D2KF2FJ24f32Z+ultXn6cntsKp4y484md/DaAGv5t
 xXPsuq+hT9SpNI08J7wL7AJnunBsEgz98Bx6Stwms0ADKctCIKFSTUVVcfcSJLMajAl6p8
 Jxuo3pQU2lBDUaEmHfSbphpiyLNGe5A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-pK20W24oOhGJYZxEWAh9_A-1; Sat, 30 Dec 2023 04:32:42 -0500
X-MC-Unique: pK20W24oOhGJYZxEWAh9_A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-680884baa49so30231846d6.1
 for <qemu-devel@nongnu.org>; Sat, 30 Dec 2023 01:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703928762; x=1704533562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cNyTpVttesOSPrSfGnZaWOQma590izTmu2hBWENTCkA5KQR1EpQfoeNPl9YxLu9MVh
 ACliKfx2izXYns5w/1+YYyHZf0ZOjleR4GdmO6WBWj+CbwsUy1FtpnuAVqDCVSuHZwSB
 FWfi5Iwzg+DZ7IGFdWi0wOH+RZWEXG5R3SiNMyRLow0vHYKgOswDZD7Fv6oV61BU96JO
 SCTpnKyhHvUNXVxcCGVwwOYl+KSSW5WGZs3eCTClm7sVJv04gq+HQ5Igd81Q8fnOCGmP
 usN+jGnRTbBaJdHSCilu2gf6co0ip0vycNmZVjaideR2S4UEi2l+o7ZS9cy0U2RD8P43
 LUBA==
X-Gm-Message-State: AOJu0YztCR7cIO7q9bxV49uWMzRIZGG4aaG8XHctyr3DfGMJ/oZXkZFZ
 sbkML7HCsANWXMkOaqSd6nib4RanjWqMTQqvsTdji4j9MXlEN81IoMEfGH9TzBM0up5HrwHYQEY
 P9Z3LaR5Z8OP33rv9Mb/YfAzBrQhRe4w=
X-Received: by 2002:a05:622a:1214:b0:427:edba:238 with SMTP id
 y20-20020a05622a121400b00427edba0238mr6870112qtx.76.1703928761855; 
 Sat, 30 Dec 2023 01:32:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdfd0xLaL6kw7LE26eqPAAM7ygJGVofyCbFlvaq1LyS4akXcVBqll8vEa4gUExW0K7YAWszA==
X-Received: by 2002:a05:622a:1214:b0:427:edba:238 with SMTP id
 y20-20020a05622a121400b00427edba0238mr6870098qtx.76.1703928761523; 
 Sat, 30 Dec 2023 01:32:41 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 hg19-20020a05622a611300b00427e708cc91sm4094818qtb.42.2023.12.30.01.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Dec 2023 01:32:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v2] esp: process the result of scsi_device_find()
Date: Sat, 30 Dec 2023 10:32:31 +0100
Message-ID: <20231230093231.170086-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229152647.19699-1-adiupina@astralinux.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.553,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


