Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6216B785924
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 15:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnsS-0006ZA-0f; Wed, 23 Aug 2023 09:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYnsQ-0006Z2-Cv
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:26:26 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYnsO-0007MR-UT
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 09:26:26 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-570deae2594so1715461eaf.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692797183; x=1693401983;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gfjJ7BoqxloGhSkJ1OWsvwOE/lMWbdoTdULRiJhAzXc=;
 b=dRC9bdIEz63Hpx6+OxKD1x3q2x1RIQ8Bx0NGcRkqQi8fryFs/XJv0m//ngJLRuQlvU
 iWgbVUIusiUbOFpTGctWDa63BsSlclWZZuV+Y8qe7oCb8dLG1usdn3VAX2wcDU51nBwD
 cEGAaVddkXUIjW3X3u0umMnSQNW/pqyuwL+1xgKQJm+isSI6/tuQg7ma/ItokHItTKA4
 46NQzH0PAHQkj5/A6gUiB6sWPmitVHmH5ujNDAnwNuU76iUVLLB5LZD1T52S/f+RN+Td
 UfzwS0q2wXwNL+J+WEy6DEp3UzzAiAQFnuvamd/sRMqvmlDAHUWIVnBZPic8PmhxrltL
 FU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692797183; x=1693401983;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfjJ7BoqxloGhSkJ1OWsvwOE/lMWbdoTdULRiJhAzXc=;
 b=P74w94gI5aQ1cT9T269zWuH+qvpUaNyt6BiEwc1450Di9eVbs2eZYh4jWs2d33wyhk
 9JPRxag0lP0LOPQWNMIic81w0sHeJN6RYfg33e9FYmEpU+RKoOjIgh4JjB3Sks/TqGnQ
 mRlaF4FE9uTwEr6svBO9786nCJR8bKGNELXeIhTha9NRsmtkyTPU/XCNX2Wx5ITxEJGB
 BdFO01ISpirakBnNaKsKGl0GU+3sfIhvUkPICd5a00f3RNdzrz5FjBTCIxDYIGtkms9K
 XbAzU25O8qCoav7N5ut2vRE+S0fZUQZECSbOEpGMP6XnNLdieqYi9LCR7+IuqQesgrmx
 FgKQ==
X-Gm-Message-State: AOJu0Yzz7cNcoJq+h5MVjCfIOVoMmBx0KFvwUkdZ3CBGvSyajsJuKHxk
 eb13eyj0nYPbPxHFixJ9clTeewdFFB8nolbrZ2A=
X-Google-Smtp-Source: AGHT+IGFwHSPyhiT6qmKSnkV14FuitN8M6i0K4QOJmoykdf618MFyj/VpWM70w58DMHGyXyXMZI7jKIH1XWM7a9/Rak=
X-Received: by 2002:a4a:3515:0:b0:570:be00:5e14 with SMTP id
 l21-20020a4a3515000000b00570be005e14mr10107382ooa.8.1692797183233; Wed, 23
 Aug 2023 06:26:23 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 23 Aug 2023 09:26:10 -0400
Message-ID: <CAJSP0QU7gp1OjmrGhV1Y4jLRF0DYQAG=vn7LTS8SOa0eADW70Q@mail.gmail.com>
Subject: NVMe ZNS last zone size
To: olc <faithilikerun@gmail.com>, Klaus Jensen <k.jensen@samsung.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Val Adler <spantamd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Sam and Klaus,
Val is adding nvme-io_uring ZNS support to libblkio
(https://gitlab.com/libblkio/libblkio/-/merge_requests/221) and asked
how to test the size of the last zone when the namespace's total size
is not a multiple of the zone size.

My understanding is that the zoned storage model allows the last zone
to be smaller than the zone size in this case. However, the NVMe ZNS
emulation code in QEMU makes all zones a multiple of the zone size. I
think QEMU cannot be used for this test case at the moment.

Are there any plans to allow the last zone to have a different size?
Maybe Sam's qcow2 work will allow this?

Thanks,
Stefan

