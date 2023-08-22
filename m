Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41078444F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:31:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSPg-00011U-0b; Tue, 22 Aug 2023 10:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYSPZ-0000yE-3R
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYSPW-0000y6-VP
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692714670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=peAgG7azuYJINXCoKffQOy8JFzQseH/BR9fJWIXk0iw=;
 b=E2MyXDBYgkFmEtvAqUjjxIHcl3QlT9SNya/MzC19QvDlNC8p0GTUOLmrB06Q0srt7aihas
 OMcbFE0NeBuV15DIPECxi0GVZ6kLiuQzSl9tM89IfWZm4q5E/0W+pYH7obz2bRxtCkGA0/
 b9a8ykw9n3qK2QKZvjQwO1FqmXuSEE4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-5sT6ERV7OVWn-99prnE5ug-1; Tue, 22 Aug 2023 10:31:06 -0400
X-MC-Unique: 5sT6ERV7OVWn-99prnE5ug-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe5b94bd62so29741315e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692714664; x=1693319464;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peAgG7azuYJINXCoKffQOy8JFzQseH/BR9fJWIXk0iw=;
 b=gEsZ7B2VCWPvYbTqDcVb/qPetYAy8eH2SAHdREDN8XlTcjLgCquVc+H3GOecRaLxND
 Nn2d09l5Vloz9zMHRjIYYt39VLAuA8Cv2CvINadQf9Rr8DIZ/c+w7P6O8SwIBl+ILuoA
 bTL4xFzr8X1ziIE2Ei+gA0VxoJBsvBwyZr08ZqgmFsBowC0EipEXXQZrMwwufAQEyS0Z
 9WmYgDRJAmHl1XHmUeVyAv/3OHqtsWK2XZ7OlltTAjw1XpQHhQHc7cn0E+fUrxFdd8c/
 nIgTPs/9nzdMOnYYobU4POpgJJ5j6SYMNN7Nk8XoiJgr/30ou6W7RxJDUjOtqIkr0Mcs
 c+4g==
X-Gm-Message-State: AOJu0Yyw4X/i2szsKvQ5ZQvl0wDN51ck35XQrPmuO12p69uPJSaTHEir
 67WcrjFl5CcDNZipqecdWqOGiNJIQksvY8G9RWWLMvryXJqd3H5jxfFDNAqv7IFM6PNbWyoK7Q/
 ThlNhtoc4qc1WMDE=
X-Received: by 2002:a1c:f304:0:b0:3fc:3e1:7105 with SMTP id
 q4-20020a1cf304000000b003fc03e17105mr7386937wmq.24.1692714664141; 
 Tue, 22 Aug 2023 07:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFep9FXWI3ZSp/HcVIU0dfpYd7+/5lT6RlU/pzDbgg9No8wh2xslqvG9WP3z8hjhXk1Xr2WWw==
X-Received: by 2002:a1c:f304:0:b0:3fc:3e1:7105 with SMTP id
 q4-20020a1cf304000000b003fc03e17105mr7386916wmq.24.1692714663728; 
 Tue, 22 Aug 2023 07:31:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c?
 (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de.
 [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003fed78b03b4sm14260292wmc.20.2023.08.22.07.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 07:31:03 -0700 (PDT)
Message-ID: <29770acc-34cf-b503-5a27-65ac6878eed7@redhat.com>
Date: Tue, 22 Aug 2023 16:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 9/9] docs: Start documenting VM templating
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-10-david@redhat.com>
 <CAFEAcA9HxpO7Zzh4VA+9d8dZuc-zP9SmFDPk6-qQzBAJBsoJ3g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAFEAcA9HxpO7Zzh4VA+9d8dZuc-zP9SmFDPk6-qQzBAJBsoJ3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22.08.23 16:23, Peter Maydell wrote:
> On Tue, 22 Aug 2023 at 12:49, David Hildenbrand <david@redhat.com> wrote:
>>
>> Let's add some details about VM templating, focusing on the VM memory
>> configuration only.
>>
>> There is much more to VM templating (VM state? block devices?), but I leave
>> that as future work.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   docs/vm-templating.txt | 109 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 109 insertions(+)
>>   create mode 100644 docs/vm-templating.txt
> 
> No new .txt files in docs/, please. Use rst, and incorporate
> the information into the correct parts of the manual structure.

Thanks, already raised by Daniel. Will be an RST and moved under 
docs/system.

-- 
Cheers,

David / dhildenb


