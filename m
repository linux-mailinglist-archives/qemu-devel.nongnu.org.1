Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C307B7CD3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnylu-0002UJ-Tt; Wed, 04 Oct 2023 06:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnylT-0002GY-1f
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:06:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnylR-0002ZN-CB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:05:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso1760648f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696413956; x=1697018756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rbs7VzPQpg6YMMP8mDVhDNXZEE7p3sPPqe6A4FLvfPE=;
 b=FqOfPsJWI1MtC0DO/VBfwI7l2WSiRaLq8jwenh6rdFNyFjO+zKHvKHJ3pKhIhCuz4g
 wf58av5JVbbrGj/E4/Dyh3a/bmE7u9GoJoGUMcq58ZBQyKH3wdj7Oap0Yq0cPKoZFr+A
 lt2YSIeBuaKHCmbOplO9tBmA3EnODzFtvXcjc/9FIEGN9+aLwA6MKaZ89+s3RmGQg/IU
 IyPYPCjZX4kvuTWraM8eqNq0+GUU+ZSpspefSDsqtBblRZSuYNyy7D+FeTLSgn2eNGES
 517TFyPCs+JKoORHRbqX4Q9lV9x/oB3LNgL9TljrGRdNYk+XSAnNB08Hw/kvzFoP4GDM
 4FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696413956; x=1697018756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rbs7VzPQpg6YMMP8mDVhDNXZEE7p3sPPqe6A4FLvfPE=;
 b=Xvd4D0aF9SPJPhuLm3svCI/1frsqMMLuKfaY4cvgWFUV/1Myvv5rVvUb2xaaaw+zOY
 MEF0EM2VbaP6QPy2NmPmHJNb8NFTzysFdnEIR145KVHJ8f8e0VNJqICedRqkWZ/bfs0p
 alG2hd1bayOAF4EJyVenRNRVfelzn9QjnAfJplpJJcysZgDSP7A/jUjqslCMaZr4/bV6
 /zXAaKVOSowI7PWepwnZJmIVRVQ84qDdnEZYfAeSzgTJLq3KM5Uzcqfmoe5E84J3kyrJ
 SChooA7WegxzXIUcvVzyRq/EGZk5ZbJ1vZpBWfmV6ILZzj6S6b/hfGrkGmNHemEi0ksI
 neeA==
X-Gm-Message-State: AOJu0Yz3wOQ3oTyVrdfneNgo1e8u0N0wRhXJ1sGw4JV0PGgTdPDBuyOo
 Nn40q7l6+uTa0YY8VebqsjFxlQ==
X-Google-Smtp-Source: AGHT+IFSFj65nG8ashhBv1itTK7AUVvUecoXwPzJDZiDkXbBx3y6LzUW91nME1ZE9O+VI2/FAQc3+g==
X-Received: by 2002:adf:f80d:0:b0:31f:fedd:83ad with SMTP id
 s13-20020adff80d000000b0031ffedd83admr1729745wrp.4.1696413955687; 
 Wed, 04 Oct 2023 03:05:55 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 p5-20020adfcc85000000b0031f300a4c26sm3603299wrj.93.2023.10.04.03.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 03:05:55 -0700 (PDT)
Message-ID: <943d5ab9-cb8e-71fe-f230-7be74dbb0b76@linaro.org>
Date: Wed, 4 Oct 2023 12:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hw/virtio/virtio-pci: Avoid compiler warning with
 -Wshadow
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
References: <20231004095302.99037-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004095302.99037-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 4/10/23 11:53, Thomas Huth wrote:
> "len" is used as parameter of the functions virtio_write_config()
> and virtio_read_config(), and additionally as a local variable,
> so this causes a compiler warning when compiling with "-Wshadow"
> and can be confusing for the reader. Rename the local variables
> to "caplen" to avoid this problem.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Fix virtio_read_config() function as well
> 
>   hw/virtio/virtio-pci.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


