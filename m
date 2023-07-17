Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E62756AB0
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLS5a-0004lE-V7; Mon, 17 Jul 2023 13:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLS5Y-0004j8-BE
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLS5W-0000VD-GL
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689615165;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhn400pb7+NEFIHylSRvV/lRvxCONtORbBhhXurrMgQ=;
 b=EZ2HW1yN7+zl905SJJ940aeYPz1aRnT7BHr2EyThlzWzaOiJlOMg5a77H9WOJ/Ke7GXIZd
 EVKmfiQN6Yrghx0oTd9fXQOrXn70GoWZH/x5AEYt/6Xg5hlYQtIZPlYa9kd6B8Si6ewv8R
 sW/Td9XRLTq1OVBOG/U2qnLSyieCZH4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-YqgsiiA8OFy4Rz0CPBeajA-1; Mon, 17 Jul 2023 13:32:43 -0400
X-MC-Unique: YqgsiiA8OFy4Rz0CPBeajA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6238c3bf768so49547826d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 10:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689615163; x=1690219963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hhn400pb7+NEFIHylSRvV/lRvxCONtORbBhhXurrMgQ=;
 b=N5jynteNwnuzfaIoxNKGeLZFqIRLvIFyNO1PJSOEXymLwbCN37o9aMOWb3Rb76xiSx
 KQlWACHv6E3EJbVnuG5XWwhXEt5NJ9gFepmed2b5eQ0ne+gr0XHi9Oq07g6iHqfU0ca0
 OmH7ayEqojrZ+Qa+dd3yvKzPHn5t8ldbIm2fcxpGAuT4vKiESiZ9h4f99l5uhyqHGIoO
 oi6O/yowhBCEwTHoxLJwJwyh1MnMjhmqcYlU7kNcmMLlcMDflMXQlgRugnzXu0u1mKCH
 jx44m0/PkSpfIbvnu68VjUz5La+3fw474KlSeBlb82g4TncqiOFNbvPWAPusPf4UGXuT
 4kPA==
X-Gm-Message-State: ABy/qLbQ4ZvhhFgAkrsk72qDBd9AQl7PGRgWzjDx6HQykUvx9/Lkvmpf
 CJHMxdW+2qsH1P2sAemVYr3J5gucoEhdXwHjj1lzYCX0lw0nqCy19PyZtoOhlg8x9+wd1lPS9P4
 66eXWwqpZDGyJtmU=
X-Received: by 2002:a0c:ab46:0:b0:632:32ce:7947 with SMTP id
 i6-20020a0cab46000000b0063232ce7947mr10283761qvb.28.1689615163454; 
 Mon, 17 Jul 2023 10:32:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFClHVyB8Dt1N97MsFc3X9VVxlwCgby34BnrJitrawVC1HaSoC+1L8tm9Nh+9cmjKH92xsn5Q==
X-Received: by 2002:a0c:ab46:0:b0:632:32ce:7947 with SMTP id
 i6-20020a0cab46000000b0063232ce7947mr10283747qvb.28.1689615163182; 
 Mon, 17 Jul 2023 10:32:43 -0700 (PDT)
Received: from [192.168.43.95] ([37.168.249.127])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a05620a14a200b00765a7843382sm6207434qkj.74.2023.07.17.10.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 10:32:42 -0700 (PDT)
Message-ID: <8a706e88-ef7c-b914-bd1a-3272f9bee010@redhat.com>
Date: Mon, 17 Jul 2023 19:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH for-8.1 v2] hw/virtio-iommu: Fix potential OOB access in
 virtio_iommu_handle_command()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org
Cc: qemu-stable@nongnu.org, mcascell@redhat.com, taoym@zju.edu.cn
References: <20230717162126.11693-1-eric.auger@redhat.com>
 <d28e1e4c-0c7c-e527-4f35-46ace2daa734@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <d28e1e4c-0c7c-e527-4f35-46ace2daa734@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Philippe,

On 7/17/23 19:26, Philippe Mathieu-Daudé wrote:
> On 17/7/23 18:21, Eric Auger wrote:
>> In the virtio_iommu_handle_command() when a PROBE request is handled,
>> output_size takes a value greater than the tail size and on a subsequent
>> iteration we can get a stack out-of-band access. Initialize the
>> output_size on each iteration.
>
> A backtrace would be helpful (or reproducer).
Well the way to hit it in explained above. PROBE request followed by a
different request consumed within the same virtio_iommu_handle_command()
call
>
>> The issue was found with ASAN. Credits to:
>> Yiming Tao(Zhejiang University)
>> Gaoning Pan(Zhejiang University)
>>
>> Fixes: 1733eebb9e7 ("virtio-iommu: Implement RESV_MEM probe request")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Mauro Matteo Cascella <mcascell@redhat.com>
>
> Did you mean:
>
> Reported-by: Yiming Tao <taoym@zju.edu.cn>
>
> ?
If I understand correctly trhe actual people who found the issue using
the tool were those I mentionned in the credits section in the commit
msg. but unfortunately I don't have their full address. Mauro Matteo
forwarded me the report which transited though Yiming Tao. Anyway I will
be glad to put more precise in the R-b tags if I get some additional info.

Thanks

Eric
>
>> Cc: qemu-stable@nongnu.org
>>
>> ---
>> - added the Cc: qemu-stable@nongnu.org and copied 2 persons involved
>>    in the reporting loop
>> ---
>>   hw/virtio/virtio-iommu.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>


