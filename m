Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C974375989F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8LI-0005Jj-V4; Wed, 19 Jul 2023 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8LF-0005C6-F6
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8LD-0000JU-TS
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689777587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PP8zxcYqTGkleZnyDv+4d2w4ytLvEGWzCpS3UpXSQwY=;
 b=UTHonXmJtkzhmlmnowMKN8cV+2BdFsIDgVQq6Vc6QM3EEtTmBXBPUrJe6pKz2kPAGOzdQM
 5OHfmhnALuqrSAYO1MtpXjgYLbzxzRmgEHIZKHxR7yMeg6hidpX98OZK3CmynhXjCYUkVE
 YHm7K4qAxC83VGNBsrVhgE/d7cPex5U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-NokbQKVXNFq0v9-HtkWL9A-1; Wed, 19 Jul 2023 10:39:46 -0400
X-MC-Unique: NokbQKVXNFq0v9-HtkWL9A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fc0094c1bdso43395165e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689777585; x=1692369585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PP8zxcYqTGkleZnyDv+4d2w4ytLvEGWzCpS3UpXSQwY=;
 b=itxvtbMxGH/3l7KYrJ2zNwbc1Q3Gr8GmwWnqEns6ov8Up/HCYQBlHClq99lIGw79AY
 uQiu25lSSVMWtCckYILd0jQ1v36e3wbyCdbmIzAmKQ9Ia4aBAv1P+yKhyc4gV7pLH3h3
 zRXf2zCzGSWPzrVBOTLeMkFk5aZnFSZOGYDhllrChxf3vGPt8B4tvna66WMu5YPQcnhc
 zY1Cl9B0YVxhuCO7eabe0DGdnspEt4x4uts8Qd02wT7oW0D0ulDXB1mzwOTt1p+FQEOW
 koKjHdng3smN3VIAJGKQfAdHTWQ7e49U511CLoqkMgTfxgjV+XEYSXrH5+JVeDsieErT
 v3hA==
X-Gm-Message-State: ABy/qLYn688qtvsefJpcqDHNR0Is/t7dJQwdTdzYLGPbBF1WmzjkvBMo
 QMlKtIW0Ynpk3UPaSashy0gxH+PaqfPG+0w4nDNHfLn4r5VR9R3snqbC92BVTaDUTOchbfaOhKG
 vhDUPY+ZB+0qwXjU=
X-Received: by 2002:a1c:7506:0:b0:3fc:55b:9f6b with SMTP id
 o6-20020a1c7506000000b003fc055b9f6bmr4626087wmc.19.1689777584919; 
 Wed, 19 Jul 2023 07:39:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjAn4NvLhTPz89Ufej6mSg6IyMOiJEl1O3VIyo4UCbKMzBe+e5uu1dQsM4V5P2un7uAUT7+w==
X-Received: by 2002:a1c:7506:0:b0:3fc:55b:9f6b with SMTP id
 o6-20020a1c7506000000b003fc055b9f6bmr4626076wmc.19.1689777584722; 
 Wed, 19 Jul 2023 07:39:44 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 c16-20020a5d4150000000b0031411e46af3sm5464565wrq.97.2023.07.19.07.39.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:39:44 -0700 (PDT)
Message-ID: <6da7eb7d-4dfb-ebcd-701e-894844851ab5@redhat.com>
Date: Wed, 19 Jul 2023 16:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 13/14] tests/tcg/s390x: Test STPQ
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-14-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230719094620.363206-14-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/07/2023 11.44, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target |  1 +
>   tests/tcg/s390x/stpq.S                  | 20 ++++++++++++++++++++
>   2 files changed, 21 insertions(+)
>   create mode 100644 tests/tcg/s390x/stpq.S

Tested-by: Thomas Huth <thuth@redhat.com>



