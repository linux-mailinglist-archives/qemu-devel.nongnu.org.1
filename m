Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7A97B9AE4
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:21:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGnC-0003Wx-3f; Thu, 05 Oct 2023 01:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoGn9-0003TB-RJ
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:20:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoGn8-0000gh-Cs
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:20:55 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27777174297so374629a91.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 22:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696483252; x=1697088052;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yr7LZCVN4PrPqxJMsWTGO5UhYtaCq11F0GbO/I54Ti4=;
 b=Aeau0rGDamq+SEm9iu6H90tfBtLBOSQ0ZoWnU5soULRd3DzlwVdbM54boa7tvXsYjl
 OJDXWLdc5xXf/PcIEf6W5OSlH3wPybE6iVwCAQwjeL9yx9L6acIA/yf/3VS5/NHROXuI
 xwWwin6LpGM0aDwfweaHI6FldDAX6LO+vaej83muMcLzmJKhLn2RQjJGG9eBKLjvtSGj
 B8tfEiCzEme/4pMLacnjJ2wzDlyXhvKL453HEJzx3XHMZX5jN1NfTAc3Xid5uVd3C2r9
 Rh+nmBaoMX8tMCtA5+081YvUFmZMJcv1216mqt/6cd27Bn/wqJ1q4T5VFqeCmqn2nejo
 bWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696483252; x=1697088052;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yr7LZCVN4PrPqxJMsWTGO5UhYtaCq11F0GbO/I54Ti4=;
 b=Px8B7AWi8PeNBjbANPYVidy5KAja+FUevBePqezwvZ3YDHqsEwBCHY4V6NqKvggCm3
 JbG+PRX3yXLWTqTaR/2G9MtP8o4IRs/AZFTzLRdGzcQ1YpmjJ/7MIa2GvviThyQPPhGz
 snZkAA0ss6jUrF5qLvrE7MNHbLnOYmI+l5XCfv7tkZN5pQMvf5XNRZzcfhplXs3Bruxp
 +Vy2jCTQTKBrEFKuDH+DPOfpalSe1K2ljjBj/gTqUvLhd99BiEYcZNmI+GSt0cIv2jJT
 p1jvfbVZlV9892FbmC6AcpfphhEy8k7ibOvaQ88JJ/Y7tnBI0w+BsFLrVj7A6NIJw6vS
 xR1A==
X-Gm-Message-State: AOJu0YwinaSUzq7tXg9rMM403eXSc9u9Y0C6OEU9CdoJw+Eo5X8Ulpjh
 o59dGTkGN1Q20mJOqxWE0LVUfA==
X-Google-Smtp-Source: AGHT+IF+qihR4H+Nmy7zABIBDLt31pDU/P0JB5GvQidRP5jGFJHLUD4FgV2N7wb13nFNhShYZlDvZA==
X-Received: by 2002:a17:90b:1d03:b0:26b:5205:525e with SMTP id
 on3-20020a17090b1d0300b0026b5205525emr3825832pjb.42.1696483252578; 
 Wed, 04 Oct 2023 22:20:52 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a17090a804a00b00263b9e75aecsm538548pjw.41.2023.10.04.22.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 22:20:52 -0700 (PDT)
Message-ID: <04252a01-94f7-461c-9530-e1b7a309e9a8@daynix.com>
Date: Thu, 5 Oct 2023 14:20:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] elf2dmp: fixes of code analysis warnings
Content-Language: en-US
To: Viktor Prutyanov <viktor@daynix.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, yan@daynix.com, viktor.prutyanov@phystech.edu
References: <20230930235317.11469-1-viktor@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230930235317.11469-1-viktor@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2023/10/01 8:53, Viktor Prutyanov wrote:
> This series tries to fix Coverity warnings.
> 
> v2: fix commit authorship, add CIDs
> 
> Viktor Prutyanov (2):
>    elf2dmp: limit print length for sign_rsds
>    elf2dmp: check array bounds in pdb_get_file_size
> 
>   contrib/elf2dmp/main.c |  2 +-
>   contrib/elf2dmp/pdb.c  | 13 +++++++++----
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 

For the whole series,
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

