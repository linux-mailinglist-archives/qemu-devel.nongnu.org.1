Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C87CE81DFBF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 11:33:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHiFN-0004nU-6l; Mon, 25 Dec 2023 05:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHiFK-0004l7-Hm
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 05:31:42 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHiFH-0004Zn-VN
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 05:31:42 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2046b2cd2d3so1301789fac.0
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 02:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703500176; x=1704104976;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MM4t9Y1/FJUY7Mm95C6aH2oAsAlgOIq5wysU0eDf10Y=;
 b=xhKnFy03g2pbSVElt5jnOMWI7ryy7HVBf+Mb9/wrLdY3KWkGjJZNQyg3hELgLDYhen
 5qLdpcKwxEhDBcGSfrTu4LV3Cvv3Ll/fU3jvJmCvBEgBcvITQ81QIrSjLjh7EScAV+UC
 A5dTunUrHTWnKMCUjVv2Bz7YAcqLa31Kd9ECf27870jDn6ovZCIvbPpqUoqBzEhGRKvy
 GTPYynoCKBwQIXq7gH2KKC3WCPVbHSeRUVuo4j8Fruzdhg0g7wpJ115S68RtIYW0+mhm
 oTUjdtrHqMrbmee/bCFZplS/ReHuvBWmaqjUmxFJXKuSBZt02xRlPjmSl/R79H/bBTUJ
 KEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703500176; x=1704104976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MM4t9Y1/FJUY7Mm95C6aH2oAsAlgOIq5wysU0eDf10Y=;
 b=ngSuKPqxffedpLumvHliSY9zjCYAfwQMQD+iz8CWznrvbo0kFV1ISa+oD9nCugdhi9
 fXA4SExSLclEw3fhg41l9stH1aZLYTn35CjVBgvUpkDQOxcACQh1iX1Z5y/cBNdv9zCy
 iHSnOQgP/1vp8QE1tTiKIWpRLoZucRMdk6tGgNRUyQJrObGeGaZxbnqjuaKGrtoMwpty
 uxS5M/uPzCvgx1p+T+36ek7vtNIRyWyra5xbWr2oPxmwGgGFA1SWWseSe9zYnyrkO976
 m3VLv7wRrBNmwww+JZ4o2Sm5hLVfTuyGycZhi4LCWEnjLbRp1KK47iRRrqlTnUmnhcAA
 un5Q==
X-Gm-Message-State: AOJu0YwLmcM2g5xEBvqNoxmLd/TzOe8wCRCT6ENjqvQjBysWq3GcLzBC
 xevddmHL0K7BzsE+8aq2maPwcEYd6slb8RXNsfgKlGIQdGSpRQ==
X-Google-Smtp-Source: AGHT+IFWrbAvC/P/5yhiC1prTuWwAuKRhgJd6v++qKUwy25mpaWrlHy0SfoNEUJeL3JEUQiIlUBG5Q==
X-Received: by 2002:a05:6871:6111:b0:203:a1b8:b8f5 with SMTP id
 ra17-20020a056871611100b00203a1b8b8f5mr7403531oab.71.1703500175580; 
 Mon, 25 Dec 2023 02:29:35 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a654102000000b005c21c23180bsm6139906pgp.76.2023.12.25.02.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 02:29:34 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: yong.huang@smartx.com
Subject: [PULL 0/1] Dirty page rate and dirty page limit 20231225 patch
Date: Mon, 25 Dec 2023 18:29:26 +0800
Message-Id: <cover.1703499705.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2f.google.com
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

The following changes since commit 191710c221f65b1542f6ea7fa4d30dde6e134fd7:

  Merge tag 'pull-request-2023-12-20' of https://gitlab.com/thuth/qemu into staging (2023-12-20 09:40:16 -0500)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20231225

for you to fetch changes up to 4918712fb1c34ae43361b402642e426be85a789e:

  migration/dirtyrate: Remove an extra parameter (2023-12-25 18:05:47 +0800)

----------------------------------------------------------------
dirtylimit dirtyrate pull request 20231225

Nitpick about an unused parameter
Please apply, thanks,
Yong

----------------------------------------------------------------
Wafer (1):
      migration/dirtyrate: Remove an extra parameter

 migration/dirtyrate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.39.1


