Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004947CBD31
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfEK-0005b4-N3; Tue, 17 Oct 2023 04:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsfED-0005Zf-IC
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:15:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsfEC-0002Hq-5f
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697530499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vAUXAak9feFpZtKDm8K9taebrI5e4GOyCoPIhnclnfI=;
 b=GQ9pi1+/Ii07Fi/pttMv3iAkH+JDPdVPJQvWvuC0m/bywHlOsMSFUgh8xfrdbP0il8hFCY
 ZFa9m0oMJV6OuBNmP6MblH0zD1V6svp0UchjKgaawUeiKekbsG7vkjaSV6pi1RX/mtPFyv
 2brlBQBiHN4ND2t3v9202ajdqXJBkrc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-D0h8K1VkP9KQW0awAqLm8A-1; Tue, 17 Oct 2023 04:14:43 -0400
X-MC-Unique: D0h8K1VkP9KQW0awAqLm8A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-407558fe418so38033785e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 01:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697530481; x=1698135281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAUXAak9feFpZtKDm8K9taebrI5e4GOyCoPIhnclnfI=;
 b=FdjwWWBWmPEaEMFz4e4Grtqw58MiakguRIxE5GD0FKlKEteva59ZjcWkyq/Ksuw2MW
 watW1GPprwPqY1DGAvdbdMWgb84Zyx4Po3XL+F1jLpiHisWAEkiVbarJbxSVGEWA2psL
 ri6B6rUXPgKFAfaNvYqGEshaob28ZXOA3ze+E85F2U84dfguFDze42G5ZQja1CVHVooa
 2IDzJLkrUT3faC7sw3Y4xsFnpQ3UZ4dd7IrV+NyJEotuuLl6uLjlACm0uBmASw3L0CCj
 pvK2Lfp5PYZhDkzO/0CPIvix80JiBgV/X1VxOytY7WqbV4tTbrqTybY6vXsHrQWxM/92
 d9xw==
X-Gm-Message-State: AOJu0YzKDc9Y+LNr0jCtQPvWVLlW0EsqyNhu9zPtaj9w2si9f0uW6AH/
 L0bVXmlI1cF4AlqZF9Fmj4qNCBlnYJgrbhz8iGA281aUpdYY6oy+ClOnFteF1osUlWkxB+MP7jN
 WtKUesUyu/P2nk9E=
X-Received: by 2002:a05:600c:46c3:b0:407:5adc:4497 with SMTP id
 q3-20020a05600c46c300b004075adc4497mr1115184wmo.9.1697530481524; 
 Tue, 17 Oct 2023 01:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHruBX+OfTHUCIEVQNN9nWulXPhAtw7yd5LBMjSHJM4lbiDD1l3hclAoSNpxxoynEtAxpUZ7A==
X-Received: by 2002:a05:600c:46c3:b0:407:5adc:4497 with SMTP id
 q3-20020a05600c46c300b004075adc4497mr1115164wmo.9.1697530481144; 
 Tue, 17 Oct 2023 01:14:41 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a1c7707000000b0040586360a36sm9073723wmi.17.2023.10.17.01.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 01:14:40 -0700 (PDT)
Message-ID: <50116c43-5fb6-ad87-a748-12e02d596c13@redhat.com>
Date: Tue, 17 Oct 2023 10:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org> <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
 <87lec2dc7r.fsf@linaro.org> <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
 <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
 <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17.10.23 09:53, Viresh Kumar wrote:
> On 17-10-23, 09:51, Hanna Czenczek wrote:
>> Not that I’m really opposed to that, but I don’t see the problem with just
>> doing that in the same work that makes qemu actually use this flag, exactly
>> because it’s just a -1/+1 change.
>>
>> I can send a v2, but should I do the same for libvhost-user and define the
>> flag there?  Do I have to add a patch to do the same for F_STATUS, which so
>> far only got a placeholder comment?
> Sure, that's fine too.

I would rather not, though, and don’t see a tangible benefit in doing so.


