Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2AC7395AE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 05:03:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCAaE-0002S5-RJ; Wed, 21 Jun 2023 23:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAaA-0002Rj-Sk
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qCAa9-00015m-4i
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 23:02:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b52e55f45bso32423915ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 20:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687402919; x=1689994919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bHofG7CrnAk4nDIcLgG7PFbqjaFYBESwUa42jQJ79vI=;
 b=dk8Q/CgQFX8Es0sq0ahbGjWq0doy8yoE+n1fryMbljBibSnCA7BoQH2Oiu/iCmQGlZ
 qYRNlRGTsHXhUA5H7OxGBowQNrB2LMVRXYXQ6YZk8FS2cC1sTZ7XheGW9k25UoNseR3C
 npPwqlnhEi0COc7ao6t/E+Fo/SX5t+B50wQ51FbobbKOeMAhd9v4EuwCfTRFhLeltB3W
 pEkHRMIwtyBUYEIvPMpE8OsqTPQ6ZWkndf6jDfYskZ/eSYYPWrFQ6lvVAMU7+ask7tt5
 QsXJauCOndpq3kXAB0ZRDcTbYSOZ3gBqDCJV3zbGyN49lLPwSb5XN6E+OFYkOTQq0ksS
 PsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687402919; x=1689994919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bHofG7CrnAk4nDIcLgG7PFbqjaFYBESwUa42jQJ79vI=;
 b=UGtvjsLlXh44ILH8MYC6FEO6FnBe2xx1eafSEOfAZBqKzGF38CYl6DTXFvUyLACp1o
 TeC08saQP+gStiGJ8FbmtLe5AQ5MmbQTNx3SrTINIP0T0Ueb4xt17Vr45csY+lIMFnY1
 TV2hY78AvKvNRFB0QEWkGffx0MQ/NtA8kvMQVRjH0tORZREZQTchHVk+Kg1mpOqQkYN3
 Gp+leNjPKoysU56ZTsUxTA/4erJsODn1Mb9f1nA9lgj7dfEY2KyWrheNRHwma7XApVUv
 Qy1shxtuUhjGe2fXNRKJewLRJq8RvO6z0Aqh4HVbBLINV91BO0PAfXtWrB6jyDZIsMWA
 pDgQ==
X-Gm-Message-State: AC+VfDwO8c19hx+lzzhfY0VA/Wa7IxbBnHqdF7RrCpGqvETSaCI9KxIJ
 wKBil0S47UQysyPuqDWV8zM=
X-Google-Smtp-Source: ACHHUZ59DTeNShO9/gWQ3f+nep9X06GD7CPiSab2O5ToxUzHM1L76jiMDF+RHs6fhd79P9Fwnu2Uiw==
X-Received: by 2002:a17:903:230e:b0:1b6:b1f3:adfe with SMTP id
 d14-20020a170903230e00b001b6b1f3adfemr133481plh.16.1687402918974; 
 Wed, 21 Jun 2023 20:01:58 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 h12-20020a170902eecc00b001b3acbde983sm4217429plb.3.2023.06.21.20.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 20:01:58 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC 0/3] Vhost-vdpa Shadow Virtqueue _F_CTRL_RX commands
 support
Date: Thu, 22 Jun 2023 11:01:41 +0800
Message-Id: <cover.1687402580.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series enables shadowed CVQ to intercept rx commands related to
VIRTIO_NET_F_CTRL_RX feature through shadowed CVQ, update the virtio
NIC device model so qemu send it in a migration, and the restore of
that rx state in the destination.

Note that this patch should be based on [1], and conflicts [2], which have not
been merged. I will submit the v2 patch after they are merged.

[1]. https://lore.kernel.org/all/cover.1685704856.git.yin31149@gmail.com/
[2]. https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/

Hawkins Jiawei (3):
  vdpa: Restore MAC address filtering state
  vdpa: Restore packet receive filtering state relative with _F_CTRL_RX
    feature
  vdpa: Allow VIRTIO_NET_F_CTRL_RX in SVQ

 net/vhost-vdpa.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

-- 
2.25.1


