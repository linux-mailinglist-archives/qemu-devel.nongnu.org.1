Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8EF7D16BD
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtvi5-0001ui-PC; Fri, 20 Oct 2023 16:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtvi1-0001qe-8y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:03:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtvhz-0005TE-Kq
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:03:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso17818785ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697832173; x=1698436973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FiZoq74TPTmMRyxQSBZ7ueLr7YFQJ1nJ6tSEflBj/Zo=;
 b=QIYAFkMJ8Yjf0p+hvwQGaBTTuVBgawJd+IzlGjbotdW3bvbcrRnrhvoP95IukHfCbp
 0JRuv3pkP7zZSddosZlM9sX/3sUPB4DR3piAbFKbeh5q9B4CPIvZ6lzLwTemzCWHzKV/
 1AF0MPeB59qbfxgWrgrv4DoWfgOaA/5TfVHPC4oraAAZiCarKKVbxU9rvwB79G0b6O4c
 DU676wVlJDUyae/XpcFDhPIyB3bn9nUKEACmrijklcT/a/UHrbteFu+b3DKxG8seCI+X
 mpD6BJgHIdlfZctbsCutiwgJ9GHJhlOX/VWOCv30cxUIFONbxrXMqaX9jZCehQpXG3MF
 22Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697832173; x=1698436973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FiZoq74TPTmMRyxQSBZ7ueLr7YFQJ1nJ6tSEflBj/Zo=;
 b=gcb/Av+IhE10riS4dmfrb85LkShGCKF4T4utAaYv+oAt1sf9VA3kW1baQFuJILgba+
 BREswVSfaizpfmc62JbJ7RRVeGsLj/GWNhuUi3RyEXsLQM47m6tbix2Gw+0KWwTUc2/m
 Eb7SFUbEIt8qZe1rBXjXT+wkbPnEAq9oxxsj8XRenLxOQAP25uhwv0lghTP2w/RAGET9
 /CrNjMD59cgIA3ReRCfIx7LKqWG0+0fDSujz9vkCF8rkE9eqkBWldrKFaRnT3uo3Pihc
 UbfcI5Zjp67qv1PLvmgfIizFv4uaY9i9Gk82eBGJ854chwf2tUheqUow8msToQoEp9b0
 W6Qg==
X-Gm-Message-State: AOJu0YwaNb4/2vkRQoAppQFtFr1+BpWM9D/e30A9ZJtPQ5tEto7iQKDe
 bYivoeBgc0CoES3mnDkq4x+u2Sp/4JDnQdacTpI=
X-Google-Smtp-Source: AGHT+IHbotcB5w/GPPy+e8Zx2cDEnN1mqV+4STzET21bdO7oXWKAIQwb2UqrB2pdwgYSCINz56pajg==
X-Received: by 2002:a17:902:da8e:b0:1c7:36ff:1feb with SMTP id
 j14-20020a170902da8e00b001c736ff1febmr8571183plx.17.1697832173587; 
 Fri, 20 Oct 2023 13:02:53 -0700 (PDT)
Received: from grind.. ([177.45.186.249]) by smtp.gmail.com with ESMTPSA id
 b11-20020a170902bd4b00b001c9d6923e7dsm1890680plx.222.2023.10.20.13.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:02:53 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/1] docs/system/riscv: update 'virt' machine core limit
Date: Fri, 20 Oct 2023 17:02:46 -0300
Message-ID: <20231020200247.334403-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

Re-sending it with a more adequate commit title.

Changes from v1:
- change commit title from "remove core limit from virt machine" to
  "update 'virt' machine core limit"
- v1 link: https://lore.kernel.org/qemu-riscv/20231019134812.241044-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (1):
  docs/system/riscv: update 'virt' machine core limit

 docs/system/riscv/virt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0


