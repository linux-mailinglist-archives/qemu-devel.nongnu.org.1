Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B785182B532
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 20:26:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO0gR-0005v8-20; Thu, 11 Jan 2024 14:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3pUCgZQQKCtoBHSQCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--flwu.bounces.google.com>)
 id 1rO0gJ-0005u3-7W
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:25:36 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3pUCgZQQKCtoBHSQCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--flwu.bounces.google.com>)
 id 1rO0gE-0004CQ-KH
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 14:25:32 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-28b77ca8807so3559042a91.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 11:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1705001125; x=1705605925; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2+ixT0xQP+mP0HStWNqLdMTqR4OnTrGkx2KULhxhIHc=;
 b=sfbFSDOotWa4K1IF1whLoJ/MnX8qd9OqcUsFJr9HNCf6XtkiT15EGRmolqIB/SDY+2
 h2Loq12OonxxhQ2MXHtAPn1Qslfp380gGKUh5Da+7m2/501JE1ZzBWr3jqyI+b7A+5EG
 b++1UNDi/2BtH+UHiBBv+UaJ4f9qXVHtndCPSIfsVB5RUKjvPyiosE+b9UE2AMgMu+m8
 mlfYzSnvv3z0ytinMKGiUj9C11lEh3YI8J7eyS0QzoDwUkCk95Ttlpf7kGLLravAg1DX
 S3+VLliqvmnY3BTtOsaJXZiTzy0zukjpjsshS1cmkUPcvCP44mdk+r3u3gdXCv9DGuQD
 Go0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705001125; x=1705605925;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2+ixT0xQP+mP0HStWNqLdMTqR4OnTrGkx2KULhxhIHc=;
 b=pdTNxwSepwa/8xsR7Eij9QRcM5it8AUPPOb4HXljmii92BMOs69EdDyZF5MJCicLTl
 CfL3s6ZphP4GcW/GCdA0VJBS7iKELDmVjovVyr8p7f7Mwx+hfPdy/8j6alG1c9zC/1d/
 KOyK51d8V9f69OccPJwKD3ANVHi1u3lZReCArIfEbq6YQnataGNJQsTl7uSVzCG/sfQu
 O0QTHpfpTFiLwW/c7f02Wuh6IRApfe8K1707BD+ZU7Kmf678irC3iA/UWYIxnrYcQ/Zc
 8S9rAvzNIgaFldUvrYiM4oUfG/Rb2FSvgRnMvSByAwAG20Dnv/jea2eSyZQ5fu/h5d1t
 nDuQ==
X-Gm-Message-State: AOJu0YyXPKquiLfyRPaF7fX4wH6Vy4fhmkbjYUKNLc3cwOjJg+c+NdCr
 8vxUS5ss+npx/bhUH535Y8R4Zw2aUIuwhb8=
X-Google-Smtp-Source: AGHT+IFm/TBhXF+KOTW0/BxTLXT5prarEsh4JDaTxEllCH7yx4f/EvS8UZIro4w2wIz8YPzcqi2NPVkN
X-Received: from flwu-kvm.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ceb])
 (user=flwu job=sendgmr) by 2002:a17:90b:538e:b0:28c:c1ab:89a2 with SMTP id
 sv14-20020a17090b538e00b0028cc1ab89a2mr1290pjb.7.1705001125304; Thu, 11 Jan
 2024 11:25:25 -0800 (PST)
Date: Thu, 11 Jan 2024 19:25:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111192522.2795498-1-flwu@google.com>
Subject: [PATCH 0/1] smbios_build_type_8_table should use T8_BASE.
From: Felix Wu <flwu@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3pUCgZQQKCtoBHSQCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--flwu.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

It should use T8_BASE instead of T0_BASE.

Felix Wu (1):
  SMBIOS type 8 should use T8_BASE.

 hw/smbios/smbios.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0.275.g3460e3d667-goog


