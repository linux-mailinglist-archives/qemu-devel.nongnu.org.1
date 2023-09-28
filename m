Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCBB7B203B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlsQk-00035i-Dd; Thu, 28 Sep 2023 10:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlsQT-000350-Jb
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlsQP-0007Ju-Bb
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695912930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yuOz51A3REVvb46Rtqy/uo7u6e41/n7oO+s8MHE4K60=;
 b=ia/GpDh0eIb2hjFCYQlE4djNIoDsZvKE0kxhLkazPmOYfu0oiV+l+WwB/i+0LDIq2U+xWP
 sazEFxtqa4P4LbTCvn1FMv/Cc0KfDWsneI/K5XkMTvdigqmp/9s/oSbAHg55ubRlG2dPzu
 BtkY0WkGKhfTfwc+EBRfw7XROmbZ184=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-xJUbsQtiMjGE0nsSECPIzA-1; Thu, 28 Sep 2023 10:55:27 -0400
X-MC-Unique: xJUbsQtiMjGE0nsSECPIzA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65b107812f0so136631286d6.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 07:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695912926; x=1696517726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yuOz51A3REVvb46Rtqy/uo7u6e41/n7oO+s8MHE4K60=;
 b=V0t/PXp2j3zojdzMrR67tQfJInFcoMPvH5efkz2SddHIE8HXqRte2ifbnucb+ovGsS
 0v9fVH4ZShtgvpbJFsvfPgQwCpL4LXQGq8W14jVgKggUKgaLJ+IupqPoYu1MJLsta5x3
 WKMY1v+pAmMOfglXk9xNynwL4Bj3krPFgJ/tIeUNoaVYxGIbXpwTABXVrLMTF0NCxFi1
 LXrN4HtaxEazhJdfa5AXZbIWpNcJEqhfQKcZNYNQr0FNFE84hujA19cvHJ+IeVsoWvOU
 LCVE7QY5B9yYYKIjPespmZGCMzgTw4pZC5d+z0Fh4MoKTdivyqo4tegHdn07YMuMh3vy
 V1fA==
X-Gm-Message-State: AOJu0YwQ4fe4krB8yWUik8qwhsm8BUWJiH3e6NpnLSm9Wj3zrrZ0P+M2
 w/my6fg0dlDLtTiMea6RswvstRqrcBhRxtUHtmGR0U4yhJq9Aztna4991RnMO9dtTv/iBrTC0ks
 LW7Wwp47n+FXXoyg=
X-Received: by 2002:a05:6214:dc7:b0:65a:e5ab:b044 with SMTP id
 7-20020a0562140dc700b0065ae5abb044mr2465676qvt.2.1695912926783; 
 Thu, 28 Sep 2023 07:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfWD0iOwzuQ9h52D2KYg/JVw0EPHrJu4RM6eMam8ezfPt4WCauA49NsCKLyyMLahGXSalwCg==
X-Received: by 2002:a05:6214:dc7:b0:65a:e5ab:b044 with SMTP id
 7-20020a0562140dc700b0065ae5abb044mr2465644qvt.2.1695912926532; 
 Thu, 28 Sep 2023 07:55:26 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 k9-20020a0cf289000000b0064f53943626sm3256086qvl.89.2023.09.28.07.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 07:55:26 -0700 (PDT)
Message-ID: <944bc4bd-57ae-1f30-9110-a88e80bf54ab@redhat.com>
Date: Thu, 28 Sep 2023 16:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v24 17/21] tests/avocado: s390x cpu topology entitlement
 tests
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
 <20230926121534.406035-18-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230926121534.406035-18-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 26/09/2023 14.15, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Test changes in the entitlement from both a guest and a host point of
> view, depending on the polarization.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 62 ++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)

Tested-by: Thomas Huth <thuth@redhat.com>



