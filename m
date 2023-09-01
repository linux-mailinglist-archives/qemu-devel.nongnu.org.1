Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A502F78FFB2
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 17:11:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5nE-00061R-CS; Fri, 01 Sep 2023 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc5nB-0005zm-Su
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:10:37 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qc5n9-0005Wv-En
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693581032; x=1694185832; i=deller@gmx.de;
 bh=w7ZvPco2bima+HJDswL/xrAsJWrr/eWSJw2OHc7p6EU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=d5K8Es/cZSC69srXHGeCi6D3sXDKIEuv5E7LtZVAnQqKw7s/Yd8g0f3ZceQVah8tdIkObsN
 CCk/qRjGzvGnbQCdWDB3Ohztq0LRN1WERg9R0jiAKe9O2Tdv4nFTgY6vy8wIonZXhsGtLBLma
 TGrGgLTslash5phyX4+CU5Yl/5ctXPd39ZjAB/ZrubPjB/WFNGCAk6GOODwvh2mlYWCMDf01V
 +xc0FTc604hoB5ls/+A1G3jdzMvbiFq4ZSkQLmBJsepW597pPe/YQcNwKK1reM/DHApaXTVVj
 IU0+0USOwWvFVSvEyIjTewpDfME6YX7udfKR0yXhjwMmg4lnz+Eg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.152.187]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1q3IwE0uNG-00a03t; Fri, 01
 Sep 2023 17:10:32 +0200
Message-ID: <7f652d0e-d077-a8d2-d4f3-c85c17af71f1@gmx.de>
Date: Fri, 1 Sep 2023 17:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/13] linux-user: Track shm regions with an interval tree
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <20230824010237.1379735-14-richard.henderson@linaro.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230824010237.1379735-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7fRHT497DPy7+NcY5GibnQ4cduiHTlmz4g5+mctb39S+r8iKbS
 02gkmUj1pH+yowjbKCdH9vXNFDE+x6MfEiqPHsIMhcApc2TaPUcn46/Rm/mbF9DA/9L6JCa
 zsbHTg1TVYWWx7OKuh3AfY1eK65vBNkuDK5bdd2Ym2/VLWEEny3bEcEHEUnywZt7hzHbEoZ
 dpSR0rozKBibbeawzEWmQ==
UI-OutboundReport: notjunk:1;M01:P0:DIqiYh5EofI=;tM2n0+1Cc/xOUNf9dtntSWCID1R
 Fnq8azau4/KZELpJfY2lwRbuBzw+clJBx+b+xS9FDQR/vxt1XPp2jQ+r0Hh4CXM56vGafKkeH
 aBI3hAifSxrI9pA4FbIAdRlVUZfyQWx3K/xYpSw8ZVn62d0DddOXQB1p5NIHWApSotu4+07gL
 Cm7nUhEGZOMF60JGdpofv4dAXJx4YHPEtmizGmdrK7K8m8ZNnFVJgg7AYQZMJ2Eg9V6Y8u7GJ
 sjgW9zVlOSAfM44US+K4zrRBht1T/3FPwOHPjOL7FTUx6sNHs6XVdwaqx7fhLVfxaoFuJhDnM
 fn4RYG6WaaaSMs30MyJXG9q8NMa3F4CIOjAUCF3svodrDT2zoIB1GCTUzwd46DNpUepwJ6HBn
 gKvfQsNtRm80djvlmzzN5CAZL8nmKbFpcT1RYoeqIjODXajIWmyBvkAkEIl49+XkO72BUhubZ
 OlESx3HSKGBrkWx0v0hAuHBUELsn5fdSrXovrok9r9mDXEEv3gl1CNhIdVtDKagW4SnN2+hd0
 Cn/nMGyXn0MViNtvYQBHscRjvXhEXgu3/zZsdb0iKr6jMQpXqiGKMu4okggcRx5xmxKhJfnQ5
 mtY0LIQjkBAOm0NDG6+50UnRj4d3LavxA/765vcaCgITFtjnP63rEf8o7Ub6Yt6ksjTz4Klh+
 A3cyrUllSm8gU9JOyMmR/ISNdm5X3HECCIUBvXNtP9tuKNI0lTam9geIWB1440EnLmRdWKCfF
 TKvdu+4D0A0Gsf0jkMTSkPfe7qq1iMcVwIT2a12BAvgFwNNjFd/jq22P4e9822EfDdXn9lHkA
 jCPuJ1hwpvkyw71uhnN5znpieMonyUZ7AJPBaUvbA1B99ZIpzhgI3N3xdKzfyqoVVb0cmUzmz
 9vwvUuD7Y89CFDO9ThT9nheuW5Pc2nO3GGRa8qmExbeE9buVzzi5brOBM6UjfwpNllTDtpVX7
 H0UC6g==
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.478, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/24/23 03:02, Richard Henderson wrote:
> Remove the fixed size shm_regions[] array.
> Remove references when other mappings completely remove
> or replace a region.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>



