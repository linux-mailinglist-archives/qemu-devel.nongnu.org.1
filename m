Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B35824609
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:23:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQUw-0000xC-MI; Thu, 04 Jan 2024 11:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLQUr-0000vr-Qc
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:23:05 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLQUo-0006Dg-0b
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:23:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d3ed1ca402so4870955ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704385257; x=1704990057;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mSidOPOyVp1XBOdgaJwTk1kZZnlo4E8zQaNGDGP9sig=;
 b=emuoFm8Rr4TgkYn6XHH6cqY9/o2zfFDrnHmFo2LWJXDIifShml5f6yoUU11xe2fnvo
 9YKaAWVWBmXk9bwh3ZYO6gvkXD6/RRAzVz/5u9h71WO2HMLd8bdbEkGfnpu1cPAPhEqO
 Sdbou0EdGDmkVofEddys1Oar5C6e9jpjICHAP10kEgjuoGQ7V0VYf0cA8zhSYWQpN4s0
 XDzpoK1/NuWDpsPfIzWFruEjDeEZsab1RkCsOtz5y+4h7YXQRyKniYYRgQ3br/a2w2Ba
 WRccx3TMMgj55+owG0O9a2HEyQUAV6hL4FVwcSH8e7Womrjn+GSECKnpm+ezL1LFTenM
 AdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704385257; x=1704990057;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mSidOPOyVp1XBOdgaJwTk1kZZnlo4E8zQaNGDGP9sig=;
 b=tYknrxmFuYxQGg3Z+lLG0F0R2QrC4Zj6xsb54DdubIr85ovPcQBGlwZED5bkN0KVpz
 zOTJuA5eAl4lWeYw70BciSPUMaiOLDlyJA06JtF94Bw9PvIS2IXwTMHdLxbz2WZdmx98
 6ZABWvZ7Jg12bxLcHVuwlyhJncn7bUSghm75XpHjzglmYuCLhJeA3kKYscZ7W3wLWj5q
 3y1GSv1wUdCCQLhYtenbBRzVlxBaaiENPBXPwjFSnLeR1niuQ8CktnmkoX+AV2oT8ClM
 GsypGBvCXaK+K9SR18QufFIZ+ioHtHOqRROI4BFky2ZN/92kMEH4nqQI7CeYIlH/RJTm
 NSnw==
X-Gm-Message-State: AOJu0YwEWfA/2LV8SbmGBWh4bzbqK6uVJTYLTCzrMPbfbg5s30Vfp6Xt
 jQfQyeWAHSoZaF9258g+zmqYv+bLAWPQALHgwbbYid9KXn+ah27m
X-Google-Smtp-Source: AGHT+IFcWqNSh/56AXbAWIbHJr2r41epHC1t4F0lhxrpiHX48yNUu9TKyO/MMSOQHVKFNBGARHsUxw==
X-Received: by 2002:a17:902:d584:b0:1d3:5b35:543a with SMTP id
 k4-20020a170902d58400b001d35b35543amr683561plh.109.1704385256350; 
 Thu, 04 Jan 2024 08:20:56 -0800 (PST)
Received: from localhost.localdomain ([118.114.59.173])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902ee4500b001d06b63bb98sm25987314plo.71.2024.01.04.08.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 08:20:55 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 0/2] Adjust the output of x-query-virtio-status
Date: Fri,  5 Jan 2024 00:19:33 +0800
Message-Id: <cover.1704382761.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2:
- Changing the hmp_virtio_dump_xxx function signatures to implement
  the bitmap decoding, suggested by Philippe. 

Please review, thanks,
Yong

This patchset is derived from the series:
https://lore.kernel.org/qemu-devel/cover.1699793550.git.yong.huang@smartx.com/
Please go to the link to see more background information.

The following points are what we have done in the patchset:
1. Take the policy of adding human-readable output just in HMP.
2. For the HMP output, display the human-readable information and
   drop the unknown bits in practice.
3. For the QMP output, remove the descriptive strings and only
   display bits encoded as numbers.

Hyman Huang (2):
  qapi/virtio: Keep feature and status bits in the QMP output
  hmp: Drop unknown feature and status bits

 hw/virtio/virtio-hmp-cmds.c |  42 ++++----
 hw/virtio/virtio-qmp.c      |  23 ++---
 qapi/virtio.json            | 192 ++++--------------------------------
 3 files changed, 48 insertions(+), 209 deletions(-)

-- 
2.39.1


