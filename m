Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1365A8330CA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:36:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQxTI-0006ux-A8; Fri, 19 Jan 2024 17:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rQxTG-0006uf-M8
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:36:18 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rQxTF-0004IF-5u
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:36:18 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d71e24845aso10523575ad.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705703775; x=1706308575; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=m75TI09f+WE6k8fdsxyb/k61apLxHUAbIu/tHybpsEI=;
 b=T4cKshqDedRWBwaov+yju4X873D2nQzgshJ1gShS6Nn+AKgJRpFYfHEVywlpx/8FFq
 m60SGA2afx54Np0g2QwenDoOQuX+HzLFqmQlYAcLFAM8nlOOHOL1/jr06+XwCHlNLvBe
 h1iVXd3lE6uP1h5ImGw8aECFfimDKNx+zXtB0Z5mVRkQZ84m4M8DH2bK8arXuR5Onwpd
 eV8oLcNv+ofTspqpNxUEIC+4odkFdf7Zy7lRCeOOwGBpDjFJi0ls6HpdratvYHefhd8J
 E/pYkAzyVSYaVn8Z59jYiAdBqi2GSmBbYG3vvFHcZF9BFtiRSaYJjkBU2H6AY2NgdS2M
 JG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705703775; x=1706308575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m75TI09f+WE6k8fdsxyb/k61apLxHUAbIu/tHybpsEI=;
 b=VQr+RRUUapQ21kQuM4IBYd0pyvJjsaufYmyP//J2UEYrrTLYVz8VSAdy7RJtV0xyST
 tf2p8A/tHz/LQU7uMvDM5tt/zbNfS0oeqe9Z7JBZPR9sAT0NuwcpbOWUtz5LI4DlSHGK
 d7xPXI4hDRwdPjqw2Ieaoczvacl3yfS1Op2siwm7KdnMoZCKBCkHt1DNT/8AHgXA5fwV
 bueY07WSL8Z8mUgNZVPDizxFYYvk433rkulB1/1yv4/OqGbO9U5otHPAVxmeyaI/RQQL
 75QZpw6F4QqmgfqF+qtmW+r819ke1lHVLsgqJvSTqCLNeqONdFyScwfBqSDQntW9vkVw
 5OoA==
X-Gm-Message-State: AOJu0Yz1KquX73Nzh75SmLpzWa+HcILuA0BZMLLa3oEiXMHCW82scehQ
 Hng//4tDIAcapHxEYoBu9LhJ/zHF1lJeoicLmkJXamO7tUNDUNFY
X-Google-Smtp-Source: AGHT+IEqtNwMTm8WyN+/9yGfibEMI+Tiro0/rMwR5DSwsH/DJvkv0QCgyXUyLO/uLu86RkDNXEZQYA==
X-Received: by 2002:a17:902:ceca:b0:1d6:ff69:2546 with SMTP id
 d10-20020a170902ceca00b001d6ff692546mr640118plg.58.1705703775587; 
 Fri, 19 Jan 2024 14:36:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a170902f74700b001cfca7b8ee7sm3525882plw.99.2024.01.19.14.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 14:36:15 -0800 (PST)
Date: Fri, 19 Jan 2024 14:36:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 39/41] hw/net/cadence_gem: use FIELD to describe PHYMNTNC
 register fields
Message-ID: <5d0a387c-507d-466d-8f58-bb39a4fb34f7@roeck-us.net>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
 <20231027143942.3413881-40-peter.maydell@linaro.org>
 <ce54b95a-13da-4788-aa51-2dd21a2aa5fb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce54b95a-13da-4788-aa51-2dd21a2aa5fb@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jan 19, 2024 at 02:32:47PM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Oct 27, 2023 at 03:39:40PM +0100, Peter Maydell wrote:
> > From: Luc Michel <luc.michel@amd.com>
> > 
> > Use the FIELD macro to describe the PHYMNTNC register fields.
> > 
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > Reviewed-by: sai.pavan.boddu@amd.com
> > Message-id: 20231017194422.4124691-10-luc.michel@amd.com
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> With qemu v8.2.0 and this patch in place, I get the following error when trying
> to enable the network interface on the xilinx-zynq-a9 emulation.
> 
> macb e000b000.ethernet eth0: validation of  with support 00,00000000,00005000,00006000 and advertisement 00,00000000,00000000,00000000 failed: -EINVAL
> macb e000b000.ethernet eth0: Could not attach PHY (-22)
> 
> The problem is gone after reverting this patch. Note that I also had
> to revert "hw/net/cadence_gem: perform PHY access on write only", but
> that alone did not fix the problem.
> 

Never mind, it looks like the problem was fixed with commit 0c7ffc977195c1.
Sorry for the noise.

Guenter

