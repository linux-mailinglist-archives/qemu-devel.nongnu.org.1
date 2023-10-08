Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A097BCF84
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 20:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpYBw-0005Ux-4b; Sun, 08 Oct 2023 14:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpYBu-0005Um-H0
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 14:07:46 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpYBs-0001OA-TG
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 14:07:46 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50337b43ee6so4855144e87.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1696788462; x=1697393262; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lqmfTOhg+XzH00BK83TdaoGewnQPMA0galltYkzSOyc=;
 b=XGJHOstRSAuNr5ZSdKSGJuA1QtxeHIV34uuKbHRrToZEjyCfeenWVSk0unyvcStCeZ
 tsnF+zvhcRBiLgx4Tq+vXsQIRBh2DL/R+lDEuA7aSdmZnaH2mI7gWckH31tmX16Xxks2
 8SRTnXrE0mII28LqNk/deKm97RWDAWu4X1TWnUN3mHkrrKrt1ZLJXLZg83FkRIt8y4V/
 mZ2KdhXZldTroT4TBjmfxl4DcgP6csdknkWXPvhXqQ8BG2/EMaswA0G/Gu5z78F4xJ0B
 agQEdanqLuZERRE1tBBHY6oFoBKqzYqYnVdpE5MLp9RPdEa8ZlOdF7m7iTZ/sXXyiEkK
 yaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696788462; x=1697393262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqmfTOhg+XzH00BK83TdaoGewnQPMA0galltYkzSOyc=;
 b=UCK9rFcKoYt9EsUNnUqH5VToPxVGWCEJBR3lCdWQ4FlQrRvQeGYQtQRYDcEdo5WsyY
 BnXGUs8iiJ9JiSUDW2EYL3HWiN/f3MefkFFlkQeD9qiFsCWKXWhI+cPHHSIDj4gQ8AE/
 qOZZaU4GDfO8KK5IpDS8p6y5XUHlzJ1IR5vBiGNhJmCEHbyr8LPy2nuMkO6BqguE+wDj
 pQpddOOGZGwQzl99BRb4rCQ7Z3L9CfmdOIT9oUyo9CP2RORsMoIYH6YzzoOb2ZbS6e5c
 Spoy7HbG39qFeJA2xetadK4x2H0++cvBJpZWCXGbnKAl7Y+Ea+Eboay8IOYjL4uOs2xf
 diJw==
X-Gm-Message-State: AOJu0Yy8Ffm6Slj4qrA8qz82gPKrQbUmNep2Z2IpZmUa9bVe1zThVDBQ
 9LLJoAEmhPUU5NuXfn6PiHIMXg==
X-Google-Smtp-Source: AGHT+IEP4QD5yHF9ubjLIdHHbg7Dk+9TjgIgE46NKNiBGPq1OZGzNujGWEkXD13bRIKKv8T20PvfOg==
X-Received: by 2002:a05:6512:108e:b0:502:9fce:b6da with SMTP id
 j14-20020a056512108e00b005029fceb6damr14260832lfg.21.1696788461437; 
 Sun, 08 Oct 2023 11:07:41 -0700 (PDT)
Received: from localhost ([95.153.178.240]) by smtp.gmail.com with ESMTPSA id
 j24-20020a19f518000000b004fe64b0109asm1151843lfb.176.2023.10.08.11.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 11:07:41 -0700 (PDT)
Date: Sun, 8 Oct 2023 21:07:39 +0300
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 lists@philjordan.eu
Subject: Re: [PATCH 1/3] i386: hvf: Adds support for INVTSC cpuid bit
Message-ID: <ZSLv6w9JWs7pKEAu@roolebo.dev>
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-2-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922140914.13906-2-phil@philjordan.eu>
Received-SPF: none client-ip=2a00:1450:4864:20::134;
 envelope-from=roman@roolebo.dev; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 22, 2023 at 04:09:12PM +0200, Phil Dennis-Jordan wrote:
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
> 

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>

Regards,
Roman

