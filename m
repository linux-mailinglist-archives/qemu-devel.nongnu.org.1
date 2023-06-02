Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1857201DF
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53ig-0004Y7-F5; Fri, 02 Jun 2023 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q53iO-0004XG-J5
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:17:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1q53iI-0008Ie-Sv
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:17:05 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so20164755e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685708220; x=1688300220; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MhangMvHJjdaPhMX2/Lbj4p+BUY2mJrM3MiE0wIUp6s=;
 b=2VGPeWHV9hIdxC6U/K2uK3f1I+/QxT+wh3F+y9Azyk3s1nfURPNevq83Wq76twrhgW
 XV0HxQPiuG4xr1riNsaqigi1Pl/XhxDki+SnB2YsMuLyYop/dyNo7lWoTLFWHSyB2UmN
 //rPp3UjT1a/3G70xfOl3Z2HXoJWooAh31q71iTljKrzabcbsmDpyqNFkzcDkw51ajKm
 nv7up76MwehiMLAlN0S3Pk8vIbCwmwMuBv9ReHzIsdAnmkK/7oO9VEjwdzQKdiiPDMNd
 Ci7xFUL4rI5P1/lPNx+rUXdxGCsTrtmU+/A1yEfh4lAS4j781Eaet/uRAqFIlLhzRToL
 UEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685708220; x=1688300220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MhangMvHJjdaPhMX2/Lbj4p+BUY2mJrM3MiE0wIUp6s=;
 b=DzVwcFR0syUAGtcJ4WYwR42yxnlOre8qHcn98twzEmttL53AREPKOEYfq5xFUpcw5S
 Bf3gNgBBc1KIefMmOfX2dz+CWM5igqlxcrxKO5tDbe1nb4TxULisSyGCpMlu6+Db/vZQ
 cRG7pnzM5tE5FH+S3+ykSDaD9T06nZDup2iQVeEjh3B8Nh9jamoND+Cp5/2nDLW8tRTA
 n7QqmEKjygl7xBQ6btf06P/IgHsdwMmXooLboQ9gAZnuevDpdvl1O0HTFAce7f3j+LAT
 6C4o8PzfQ2aQR7wm1WklgBBrz66eQc59yINMtS7/STIJVgXTNmdEOcAh0b37HUCFwYxx
 nGCA==
X-Gm-Message-State: AC+VfDzq5dyXN80xKOc+aqVWxG16K6SncQ+BZ5gEDaOM+kD0FD6ZVD0d
 hYuDs70lbSp/pmuwgtJ29WIBzQU0VMgONpP/QoU=
X-Google-Smtp-Source: ACHHUZ6t1Tv3nGqbU1gA25sOo6xJ7QVbMYhIVrBxEqGv8+lnNza512fMzymCGu941Cx/t/Dt/w+mZw==
X-Received: by 2002:a7b:cc85:0:b0:3f5:fb98:729e with SMTP id
 p5-20020a7bcc85000000b003f5fb98729emr1888364wma.22.1685708220549; 
 Fri, 02 Jun 2023 05:17:00 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 z16-20020a7bc7d0000000b003f605814850sm5391847wmk.37.2023.06.02.05.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 05:17:00 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: RFC: target/riscv: Add support for Zacas extension
Date: Fri,  2 Jun 2023 13:16:37 +0100
Message-Id: <20230602121638.36342-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The Zacas[1] extension is a proposed unprivileged ISA extension for
adding support for atomic compare-and-swap. Since this extension is not
yet frozen (although no significant changes are expected) these patches
are RFC/informational.

Cheers,

Rob

[1] - https://github.com/riscv/riscv-zacas/blob/main/zacas.adoc


