Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD27A46AC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:10:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBC3-0001Yt-NA; Mon, 18 Sep 2023 06:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiBBq-0001XB-Aj
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:09:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiBBo-0005AP-Kj
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695031752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsqfwcpGt+dg6QG11K4b3JdT8Qos9ckG8YcH5YdrvTI=;
 b=hZGt1FLGicyBUfnKRcUXFVKOhhT6dBWMknDC9N4j0pMgZpV1yn8PmwyELT3Hb0GXePs46b
 1PpIEnBMokHeV3GEY87dGMRZ0xkmiE/Bw/xi1nMNYBbYgfSuU+aTOzfxvwtYSPh32+LqHO
 5OcLh/xz7aroWAI2RH469i2T1WsNeL4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500--f-DFQfFPzaEyX7e8tBUpA-1; Mon, 18 Sep 2023 06:09:10 -0400
X-MC-Unique: -f-DFQfFPzaEyX7e8tBUpA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so2882993f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695031749; x=1695636549;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hsqfwcpGt+dg6QG11K4b3JdT8Qos9ckG8YcH5YdrvTI=;
 b=k74cAN0CMvwU8Bk0v1updXxrj+fuGedw19G7iyjd1oM2RtEGMzjhd4m3w0loKXjH93
 vQXApMU688MnnLNVzZMLopHIR0bzYqff+lt84Q2X3dFqrNf0jegIbf29rjcjvZOsLslP
 elF/1i8omjl06tAEX0fKmn0jXV7WM3GoUxx/6jSG0vyk5FUkHjy1ke7pGb8cNX7pncpg
 cgIqmL4O/F8Y774p9ZDxfLPyaQdUnJSd1a02Nkcws+0TzIdmnCmQRhQm8JJsfd/0v4py
 UglIQxfoevkV18WZx5iNzkG0uKvOgSa6wBAwqVU58ESUsAqkQhTPKjg4bLMdQCVa5/Xl
 F02w==
X-Gm-Message-State: AOJu0Yx+z/dr+p0D/syKNggqdtRN0r6YS0jZiYNJa1zqTKw9CyGhVTim
 i6WJdHShUincjdZFYdjNlqxJSUCnJz8KdzZFy++H/14mpU2+UVMu45aoNSBsgZFJ4G2a40mklw0
 Wj898kO5VAxdIHHo=
X-Received: by 2002:a5d:48c9:0:b0:314:15a8:7879 with SMTP id
 p9-20020a5d48c9000000b0031415a87879mr6610578wrs.34.1695031749519; 
 Mon, 18 Sep 2023 03:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9K9+xksGqf4AH098O14nvIMl8y8WLJLgr3j2bFvz8LLsoiFQvci0Hp5R3M0kV73k8Nscw1Q==
X-Received: by 2002:a5d:48c9:0:b0:314:15a8:7879 with SMTP id
 p9-20020a5d48c9000000b0031415a87879mr6610556wrs.34.1695031749123; 
 Mon, 18 Sep 2023 03:09:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee?
 (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de.
 [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a5d674c000000b0030ae53550f5sm12052512wrw.51.2023.09.18.03.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 03:09:08 -0700 (PDT)
Message-ID: <8af5fb9f-83dc-f997-e761-f8e69f9515ac@redhat.com>
Date: Mon, 18 Sep 2023 12:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
 <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
 <6cbca7b9-381b-6268-27f0-d7ea1c5ed1bd@redhat.com>
 <3A287C52-F547-4494-B803-8CFC50CBA175@redhat.com>
 <30f0ddfb-6eb7-84a5-04a0-e11905451733@redhat.com>
 <A354B36D-A86E-48D9-B8B6-DC35D8976410@redhat.com>
 <34403090-b4b3-990f-7723-1d56d8053bd5@redhat.com>
 <08530A80-90F3-4E33-9B1A-E71A66726123@redhat.com>
 <e052a3c4-33e9-1d75-dc9b-3c64f8ae777b@redhat.com>
 <41A3B19D-87B7-4FD6-A5C7-17D758B2DB37@redhat.com>
 <143a437c-be99-d6d8-732f-e9544e2d9b35@redhat.com>
 <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAK3XEhOQCudb0VsBHFfubbcRredLMuSQCTA6fhbg99f7W9y5PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 18.09.23 12:07, Ani Sinha wrote:
> 
> 
> On Mon, 18 Sept, 2023, 3:03 pm David Hildenbrand, <david@redhat.com 
> <mailto:david@redhat.com>> wrote:
> 
>      >>
>      >>>> /*
>      >>>> * The 64bit pci hole starts after "above 4G RAM" and
>      >>>> * potentially the space reserved for memory hotplug.
>      >>>> */
>      >>>>
>      >>>> There is the
>      >>>>    ROUND_UP(hole64_start, 1 * GiB);
>      >>>> in there that is not really required for the !hole64 case. It
>      >>>> shouldn't matter much in practice I think (besides an aligned
>     value
>      >>>> showing up in the error message).
>      >>>>
>      >>>> We could factor out most of that calculation into a
>      >>>> separate function, skipping that alignment to make that
>      >>>> clearer.
>      >>> Yeah this whole memory segmentation is quite complicated and
>     might benefit from a qemu doc or a refactoring.
>      >>
>      >> Absolutely. Do you have time to work on that (including the
>     updated fix?).
>      >
>      > Other than the fix you proposed I am not sure if we need to fix
>     anything else atm. Seems physical address space bound checks are
>     already in place.
>      > Re: doc, maybe. I will add it to my TODO list.
> 
>     Will you send a proper patch, ideally not using pc_pci_hole64_start()
>     but instead the same logic without the final alignment to 1 GiB?
> 
> 
> I'll send. No problem. Could you answer my other question please ?

Sorry, which one did I miss?

-- 
Cheers,

David / dhildenb


