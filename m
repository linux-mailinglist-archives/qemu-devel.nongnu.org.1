Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D341F7E6DFF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:48:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17G1-0002yb-DN; Thu, 09 Nov 2023 10:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r17G0-0002yG-7X; Thu, 09 Nov 2023 10:47:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r17Fy-0006Rn-Oe; Thu, 09 Nov 2023 10:47:47 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32f78dcf036so1355834f8f.0; 
 Thu, 09 Nov 2023 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699544864; x=1700149664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QIsrAhFpMhYGb51ZGgcGzzrbHAXCESCLllmiiSnB6FE=;
 b=dVlFeWs7G2C+0FSxYKgWisDlH3wUB8mixUKZ/DQ5xquctkaMDSvmwZ9FGenOlkpTvc
 ganfBsDmRzqdR+lPTkKl7bW5lVD5SqiylKypIvTh29a6MORI8p2uRuEy9AB6vhbVktNW
 TmxzSIuldqbJKNdB0xoLA+2cOkvGH3Kt5jX11q1qGvQ6hJeUn8K9/NONRbmkk7XAfSlr
 PtCyxz90TAERUZXmVL/KQ3CzzYmnqc9bc6YC7Xw1wN0UG239e6AD3xCCAxBAkeVT8bMo
 7VdctdGu8OTi/i9qKEE6xF49w7noFUbllSXjDYnwrRDRdNi2+8Xpo4WB6WBYSUO/HQZy
 kAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699544864; x=1700149664;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIsrAhFpMhYGb51ZGgcGzzrbHAXCESCLllmiiSnB6FE=;
 b=TD4rMAhf15PeNSXwbxrJB4YDu2uEJami4Rw8DGVCkpCdnJf/U8gP5PdwWZmYlRrNJ0
 m+/p3Y0JXu2UioOeOJH//m4JCwyyTIYfkaS3X4elkh5FrW/yp0A0t4VzQ/pvixIS62mM
 rz4jyrhqTMqPI4qGP4GrdawaS7zQ+7CHjs+54YAkH0UxP1U/dIN/QeDMlkivsvrTCdb2
 yt3oZbb+ric4aCBMoXPMTMZ0LBK31NFPAIU6DyrV6lO/KilmSthNIl2U68OP928UgTBO
 lsvOS3Qa8XBfmrmzFRHDEiWpOr+NYGSH77biEvdCkpNHKjfBL++ax2pvqNv41mSTpA9A
 51XA==
X-Gm-Message-State: AOJu0Yx8oobVeYPWSkx2+cXXbZcduq3a2nZ6XlvgK63YoXtselIKBGXN
 3NLXnRBbw3CPzMLYgl+Yc9U=
X-Google-Smtp-Source: AGHT+IEwP0rH0HLKuGubI2Y6aunJib5CTC75Re2w2jGBSptDq4tJ55ycLtpSsU7u+qT3BGAgZ/1AWw==
X-Received: by 2002:a5d:5087:0:b0:32d:a3cb:4059 with SMTP id
 a7-20020a5d5087000000b0032da3cb4059mr7030714wrt.24.1699544863643; 
 Thu, 09 Nov 2023 07:47:43 -0800 (PST)
Received: from [192.168.12.204] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 bd13-20020a05600c1f0d00b004065daba6casm2474789wmb.46.2023.11.09.07.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 07:47:43 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <b1ec4c57-954a-45c0-8ef5-0b63a7f54b3a@xen.org>
Date: Thu, 9 Nov 2023 15:47:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: clean up xen_block_find_free_vdev() to avoid
 Coverity false positive
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
References: <1c312ba88e0928527dad6bc2e1b73d8cfe4b7f48.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <1c312ba88e0928527dad6bc2e1b73d8cfe4b7f48.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 09/11/2023 15:30, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Coverity couldn't see that nr_existing was always going to be zero when
> qemu_xen_xs_directory() returned NULL in the ENOENT case (CID 1523906).
> 
> Perhaps more to the point, neither could Peter at first glance. Improve
> the code to hopefully make it clearer to Coverity and human reviewers
> alike.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/block/xen-block.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


