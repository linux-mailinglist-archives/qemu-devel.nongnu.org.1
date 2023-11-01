Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D207DE02A
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 12:11:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy96Q-000445-Mi; Wed, 01 Nov 2023 07:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1qy96N-00043D-TE
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:09:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1qy96M-0004Og-8U
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:09:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54357417e81so11367a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698836972; x=1699441772; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yqVFnW1WUFIe+4EJTxkGaGemTAQgj7XGsOKAu6CZ+Zw=;
 b=jB6Co2yjSAu1l2NizFdA/acetzLURuQQ/FgSbFjfqqphK5mkUCoxg5UFoU/M1J4f+y
 xJ20TxCYXYkXsTgwfF3vVw4WUq9hU1RWGPYjF2ZMWGtsS9L3FjRR3+RhhYbauEQwKfpl
 atp6yu/wGiKAnhv5AlXd8VD7FgCIebCffys6J1n5G9UpC8hl1SCIl8QyYq+En+tncZVk
 tTd9lBQvwbtNykrFs23y5wbCkm53psDrxvu2jIJddm/8hQEz4D2O6oAQ1BoCBHAXozcg
 B9q7buf7vZJOd/6kZKbqtps8AE/qi3L17lFvuuY3t4yhapc9pGpW3bsNiIYizRhASe32
 iUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698836972; x=1699441772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yqVFnW1WUFIe+4EJTxkGaGemTAQgj7XGsOKAu6CZ+Zw=;
 b=CzXcQjxA47qXDXi2XA9k6QbuE+S9s7PRHrNVMBhFHHPWj9nVzLCBr8Ez+TkC246Ydf
 Tw2AbSoFRS+FvMXHDaWknskFMoY3ei+8xrWzBQn53kw80dHlf8Wh2nMkqPqkPNGsu8ee
 kJL1zIf9tRr/VqMJgDw4rxMH9VpKZB0iHCgJkkNykdh1D6+lk0DO2/BsheKMXDvB9N4B
 uUgX6PoROOBxf/4r6kNkwuBVYO8Frz//rxujiyYotgbiEFQSB1pxvxd3pSWyyoo/VsYD
 XU2dKlX0ngbQFVxwDEPkZJ1J+F69l+78IoUoFCr4lH9PuwVl02Tjp4AXfuVwXuEjBcX7
 AeUw==
X-Gm-Message-State: AOJu0YyRQKiZ2QHkVfQ4esdaqOK5BzqnVbyDY9cjc98tUavmB6eOAvd3
 +A9QI0EWyDRFyRtEDy7GKyiofQ==
X-Google-Smtp-Source: AGHT+IEglgoiFzblwGaoUG696VsUyY6rrTgHoyX01C4Z9yioOlWCKk1Tbu9+fJ4ivJz7cUM0dwtdTQ==
X-Received: by 2002:a50:99cf:0:b0:543:6397:b46d with SMTP id
 n15-20020a5099cf000000b005436397b46dmr224828edb.2.1698836971343; 
 Wed, 01 Nov 2023 04:09:31 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com.
 [34.77.222.49]) by smtp.gmail.com with ESMTPSA id
 du15-20020a05600c634f00b004083bc9ac90sm1162832wmb.24.2023.11.01.04.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 04:09:30 -0700 (PDT)
Date: Wed, 1 Nov 2023 11:09:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Kunkun Jiang <jiangkunkun@huawei.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Simon Veith <sveith@amazon.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Joe Komlodi <joe.komlodi@xilinx.com>,
 Prem Mallappa <prem.mallappa@broadcom.com>,
 Leonardo Garcia <leonardo.garcia@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: Any plans to implement more ARM SMMUv3 features?
Message-ID: <ZUIx5qA8YAIbyWEI@google.com>
References: <87il6n0zlw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il6n0zlw.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=smostafa@google.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hi Alex,

On Tue, Oct 31, 2023 at 12:02:03PM +0000, Alex Bennée wrote:
> 
> Hi All,
> 
> Since 8.1 we enabled the FEAT_RME CPU feature to allow for Arm CCA
> guests to be run under QEMU's Arm emulation. While this is enough for
> pure software guests eventually we would want to support modelling
> systems with "real" hardware. One part of that is updating the SMMU
> emulation to make it RME aware.
> 
> The recently published F.a spec is available on the Arm site:
> 
>   https://developer.arm.com/documentation/ihi0070/latest/
> 
> As we have a keen interest on tracking (and implementing!) Arm features
> we have coded up the various sub-features as stories under an EPIC for
> each level of SMMU feature on our public JIRA:
> 
>   https://linaro.atlassian.net/browse/QEMU-533 (SMMUv3.0)
>   https://linaro.atlassian.net/browse/QEMU-553 (SMMUv3.1)
>   https://linaro.atlassian.net/browse/QEMU-558 (SMMUv3.2)
>   https://linaro.atlassian.net/browse/QEMU-566 (SMMUv3.3)
>   
> I think the state of the cards currently represents what has been
> implemented and what is left to do. As you can see it adds up to a fair
> bit of stuff. As a lot of people have been hacking on the SMMU code over
> the last few years I thought it would be useful to reach out and see who
> else is interested in further enhancing the SMMU emulation support?
> 
> If anyone has any patches/branches cooking or is intending to implement
> any particular bits please do let me know and I can update the cards to
> reflect the current state of work. As ever we will do our best to help
> review and smooth the up-streaming process for all Arm related feature
> enhancements.

I worked on adding stage-2 SMMUv3 support in qemu and was planning on
working on nesting (stage-1 + stage-2). However, I haven't done any
work on this yet and I will be busy till early next year.

If this work would start before that I can put some time to help with
the review, otherwise I can start working on this early next year.

Thanks,
Mostafa

