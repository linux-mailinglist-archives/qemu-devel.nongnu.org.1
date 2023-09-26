Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F37AF170
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:00:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPT-00022m-Om; Tue, 26 Sep 2023 12:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPI-00020Q-Gq
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPF-0006bZ-2q
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ozs1aXX0RO2XP8DHo6ACGbVFF75uua3p3g9aOQb9Wa0=;
 b=BlMrGrYX8v/UxPESnOJC15RUThNwnegWE19G7P4uD5UZ+OpQYxMIT65Rhb3Tr/nhiUmyRc
 LMLf43qu4fPuxylROZOp76UiRRpHkjim4vy1r4eerE0Hls3/ijLRcgRi+Q+f7NHOrwWm4i
 kk7cVTWutdjyvRxXa7Yfj7+YAHwaAAI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-K_C5l8IAPJK_7Y-aR_l72w-1; Tue, 26 Sep 2023 12:59:26 -0400
X-MC-Unique: K_C5l8IAPJK_7Y-aR_l72w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31ffa4da0f5so7082989f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747565; x=1696352365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ozs1aXX0RO2XP8DHo6ACGbVFF75uua3p3g9aOQb9Wa0=;
 b=n6t977Nmi+LWVcFDrTdrFy05J/felJr9tCk9WOaKDE5MfPwc3jEtngMeBC4c+/6+l/
 Wq9bHWo0OzS29k+Lu0GwgrpQL0rBCts9NoZPE4rmFaLW2eXUVn5Dt6l4pFP6eKUa2VHd
 iz+2269rwqiuYXU88H6SaR+ykBIrGkzLRhH16llA4TiG9kQWK02l7qV5lc98vD+8W0ul
 R+BtSax0eMUvG+aPL3ymgEDZg+1wvyYY6Hz78TjAMK2NvzPhqiWMKrWYgqP1A75tmiTr
 2PUvyZbepl3GAuI6woup9cGdxVHbCemRX55vDlFKRuoY7VsNhCEurKuKTKzFAgguXXqg
 Aavg==
X-Gm-Message-State: AOJu0YxtAdfjrHMvbsDvUZ90iT2nTO/dBGeXEEWLI3+MuX1HjVY57oS5
 euNDpBSZSjva4glg4hX3/pS3ecd4whXWfRSJ6XJgtPyhy046LYqRLEph38Cr20+sUzsL50tqZ0D
 /54ORG3i+6474YxkVYq98FdRah2mRHu93a/H+ki+b+2CDBJSnlHk6zJCrd4wuacSDY+aie7430Q
 I=
X-Received: by 2002:a05:6000:713:b0:323:3346:7d51 with SMTP id
 bs19-20020a056000071300b0032333467d51mr3191836wrb.18.1695747565099; 
 Tue, 26 Sep 2023 09:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnhq7jKcL9scKcNbZCTgtbs9/ldzidre3o0DQDiedgckIHJpXe5thQd628BbZ+pWQrYIQidw==
X-Received: by 2002:a05:6000:713:b0:323:3346:7d51 with SMTP id
 bs19-20020a056000071300b0032333467d51mr3191819wrb.18.1695747564769; 
 Tue, 26 Sep 2023 09:59:24 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adfec12000000b0031f9bdb79dasm1198073wrn.61.2023.09.26.09.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/19] hw/scsi/scsi-disk: Disallow block sizes smaller than 512
 [CVE-2023-42467]
Date: Tue, 26 Sep 2023 18:59:00 +0200
Message-ID: <20230926165915.738719-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

We are doing things like

    nb_sectors /= (s->qdev.blocksize / BDRV_SECTOR_SIZE);

in the code here (e.g. in scsi_disk_emulate_mode_sense()), so if
the blocksize is smaller than BDRV_SECTOR_SIZE (=512), this crashes
with a division by 0 exception. Thus disallow block sizes of 256
bytes to avoid this situation.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1813
CVE: 2023-42467
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230925091854.49198-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e0d79c7966c..477ee2bcd47 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1628,9 +1628,10 @@ static void scsi_disk_emulate_mode_select(SCSIDiskReq *r, uint8_t *inbuf)
          * Since the existing code only checks/updates bits 8-15 of the block
          * size, restrict ourselves to the same requirement for now to ensure
          * that a block size set by a block descriptor and then read back by
-         * a subsequent SCSI command will be the same
+         * a subsequent SCSI command will be the same. Also disallow a block
+         * size of 256 since we cannot handle anything below BDRV_SECTOR_SIZE.
          */
-        if (bs && !(bs & ~0xff00) && bs != s->qdev.blocksize) {
+        if (bs && !(bs & ~0xfe00) && bs != s->qdev.blocksize) {
             s->qdev.blocksize = bs;
             trace_scsi_disk_mode_select_set_blocksize(s->qdev.blocksize);
         }
-- 
2.41.0


