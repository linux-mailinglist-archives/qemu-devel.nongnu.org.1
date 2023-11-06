Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C467E7E1990
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 06:12:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzrtG-0006wO-TN; Mon, 06 Nov 2023 00:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzrtE-0006vq-CL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 00:11:08 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qzrtA-0000ig-JL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 00:11:08 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc5b705769so36886075ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 21:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1699247460; x=1699852260; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fxuRWJaXg5n6m+gXY6NmGS/JImWo0tQpT1IdfjzI6Ys=;
 b=YxaMAKwS+Ky1t3urutVNa9139ygwjmrAfkGO2w6XO3NVRD+gTRIBGNkdfiZam0vmjh
 ropqM5agZnn85FPSrcp1bdCuf0xBGFvTUms7acjCWKM+VLCTbzPKfmGb3lXnateSbH8W
 QnkbKmVpz6C0R5E7VWLmcLo82Bv3+ipaA6vDkYs6LXRB5I7c2D308Qbo3e5/XhOflkIy
 H6vifUu1laOJw95zLIwdOJJxDEbY2jtMPqlHjCUnEHTGY7Ymlh1IB1pUfdGZyt4KUYxc
 nQLb/f7+D1gTDI4oMrkHmle53xP1mF3lzcmL5UtZ2tj9BuJM64ZDQxGR1aWW3nKmiSaO
 Qe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699247460; x=1699852260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxuRWJaXg5n6m+gXY6NmGS/JImWo0tQpT1IdfjzI6Ys=;
 b=kDprlXh07wEAtv8azE7rbTs5dejTWVEgi3mT8zHKhCeVwDGn6GEX2vK3kOE93bTu/y
 4NgIrMeRR456QqzNkwgDgQGnIrpd4453zrCORf3o9PWPhjNRkUZIBDq9j0v0o6May9CF
 Bos/b3XUEmgXk2JlJWz1VvElKZd5b9uT6wXD+1ziP6GtUxlmL3hyTtQ/PGGJhangbXdJ
 UwBV+TMd6/jNzKSnhAqy4l6AUUcZQxEr1RzjOjKNwLzleRBIj41udBpjr9dYMh7kzR/m
 VRQpcrMmEx7m9RNFfzJCt8Oikl9c0xdtLBSARiUa9L3ac6KKmLqF6HlBFSYvvck9Kk/d
 Xx2g==
X-Gm-Message-State: AOJu0YzKTwiJC/j0kWFPzaeqpmytm6BuPzyxyDpt0sOiaAkW3SBfE0/x
 jDdVJK8nsXVgKGbhdZqETCrszQ==
X-Google-Smtp-Source: AGHT+IHgMSi/Y7GjOM/Dh5xAzdwkMz/Ax8+AtegJHUeIslSFL/s1P6owjFyv6jCPyhl3wWFamLuosA==
X-Received: by 2002:a17:903:11cc:b0:1cc:5549:aab2 with SMTP id
 q12-20020a17090311cc00b001cc5549aab2mr24041723plh.36.1699247459589; 
 Sun, 05 Nov 2023 21:10:59 -0800 (PST)
Received: from localhost ([123.231.99.131]) by smtp.gmail.com with ESMTPSA id
 d13-20020a170902cecd00b001b9d335223csm4904701plg.26.2023.11.05.21.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 21:10:58 -0800 (PST)
Date: Mon, 6 Nov 2023 10:40:55 +0530
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, pbonzini@redhat.com,
 lists@philjordan.eu
Subject: Re: [PATCH v2 1/4] i386: hvf: Adds support for INVTSC cpuid bit
Message-ID: <ZUh1X6Z-kjRvpVc0@roolebo.dev>
References: <20231021200518.30125-1-phil@philjordan.eu>
 <20231021200518.30125-2-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021200518.30125-2-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=roman@roolebo.dev; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Sat, Oct 21, 2023 at 10:05:15PM +0200, Phil Dennis-Jordan wrote:
> This patch adds the INVTSC bit to the Hypervisor.framework accelerator's
> CPUID bit passthrough allow-list. Previously, specifying +invtsc in the CPU
> configuration would fail with the following warning despite the host CPU
> advertising the feature:
> 
> qemu-system-x86_64: warning: host doesn't support requested feature:
> CPUID.80000007H:EDX.invtsc [bit 8]
> 
> x86 macOS itself relies on a fixed rate TSC for its own Mach absolute time
> timestamp mechanism, so there's no reason we can't enable this bit for guests.
> When the feature is enabled, a migration blocker is installed.
> 

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>

Thanks,
Roman

