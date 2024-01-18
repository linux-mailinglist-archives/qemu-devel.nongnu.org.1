Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ADF831D31
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:04:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUss-0003Je-FM; Thu, 18 Jan 2024 11:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUse-00034B-Eb
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:04:37 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUsb-0006Bz-Vh
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:04:35 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7bbec1d1c9dso585810639f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705593872; x=1706198672; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JwMrMTCZ61wSTjLgwWF38zDttvnIfmVfsxMfgyJJhK4=;
 b=RvFCOZlrd1Xh9u1ZCpFdkF6L4R4tn3SOXigoLiCEgaOI587RclrzHuS03+vG1+aXzS
 2ro7frUhvCdRM9Z32XX+gIQh487LuLUOAglqaYXmzAUu2rAM4SwmQ2mL/NvOrJ0bTI6x
 mgAo2H2d5CfPJN4QieALcYrBACXD2gcNdFZEeyKOB92Xc3xuJNCg+hcLZZp6+jw6YLuF
 6lO/ilYM54J/5wfZTux56jevGDpRVrSfIass6E5oeeu6epKSU/iNbRw4wL2LG0J3x/tf
 zUiciH9ZuurjH0FeTyyXj2etV5zzLvRPkiHTlHkpr+2BgTa3EoA1/+B8wNB+64qTDAYi
 UlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705593872; x=1706198672;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JwMrMTCZ61wSTjLgwWF38zDttvnIfmVfsxMfgyJJhK4=;
 b=XMOau4MEj4OIyAdUTjBEIY0wyrfUchrw/9mY/RD/YMoCZ3vrS+ZBxuW192wkQx6dNo
 tEtVivjdLLKElus/Kv3FLSaDY0jj8fRQunQZmhOdaRwcg3aVH8Q8Q9Q/dFIdqNFJhrxv
 8MFXL0qN4GzlpZvzRoM47i0jubOY3mS0HRESe93MsZRrMFQEzjGp66GEhamV+Ym+jwKY
 L3nGqCCyEQ6Hk616L8zENxWISKQtrsevkGCfv67qHaPRYuTk2AnaMrjwrqM4axWYVaZc
 rR1kX9f1+nt312XEez33GW/dVZPfjg5aaRjbU0N4ahGImGoP/OOP17iQRkmfckNfxcAW
 QP/Q==
X-Gm-Message-State: AOJu0Yw7/vY/0ob2yAuzk6Tqz2U3HJgOYOFPYYyuo/OdUT2HnVDYb/Xi
 Krcr1Qb4tyA4aLiMsqom2RQcbOwX9sTiGSs6wGSL2b7XtXoPnR9I67xg2pLN4MEB9I+gE0JzBhp
 m71AIe1rENsjHB77YxmRXEA6jNsPk8C6mRiY=
X-Google-Smtp-Source: AGHT+IFgSKqhhdgklamg3m8WvB9PPWMens6hqfaqTCHntxxuo504izyaeYuj8uzTOA9f+nB61JfXIwm3fPpv5jJ3xoc=
X-Received: by 2002:a92:360c:0:b0:35d:a4a9:7bb7 with SMTP id
 d12-20020a92360c000000b0035da4a97bb7mr1006890ila.63.1705593872691; Thu, 18
 Jan 2024 08:04:32 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Thu, 18 Jan 2024 17:04:27 +0100
Message-ID: <CAHP40m=_7zOT5bnp1FR12ohVbm-miUorh6+rrk2Rwd1jArR1VA@mail.gmail.com>
Subject: [PATCH v2 4/4] Exclude TPM ioctls definitions for the GNU/Hurd
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=manolodemedici@gmail.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The Hurd currently doesn't have any TPM driver, compilation fails
for missing symbols unless these are left undefined.

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 backends/tpm/tpm_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index 1933ab6855..c721bf8847 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -274,7 +274,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
 #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
 #define PTM_CAP_LOCK_STORAGE       (1 << 16)

-#ifndef _WIN32
+#if !defined(_WIN32) && !defined(__GNU__)
 enum {
     PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
     PTM_INIT               = _IOWR('P', 1, ptm_init),
--
2.43.0

