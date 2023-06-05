Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F0722B16
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6C9Z-0003Kq-6Q; Mon, 05 Jun 2023 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6C9U-0003JP-KI
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6C9S-0006hR-JP
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685978985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XY+DWI7gkJKzMHzInnOcb4OGsATEeEIZ2GvWeQx+B4=;
 b=DDOUL7VssfTUY6G2ejkhnCjcv9IhNu+syqNWhHT/uOX49VMFXwjB34u5xml+34FIYWYklr
 LWs6riA5wkZs1DBJrv9rE2TVAQf9HIwMPX7e3D3tsVF7Bfp1ukMfYS+KOzR0FEVS3phftG
 j1Tqhog8RTtg99XLbDUTuoT69Rzgsd8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-jvY55CCXMIyZ2mH6APN3DA-1; Mon, 05 Jun 2023 11:29:44 -0400
X-MC-Unique: jvY55CCXMIyZ2mH6APN3DA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-977e6c94186so57911566b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685978983; x=1688570983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9XY+DWI7gkJKzMHzInnOcb4OGsATEeEIZ2GvWeQx+B4=;
 b=TZQgbrKxL1HwsKk7yIujMx9dkbylQ/vqiHckA3s4Kre+NwG4kwVIxDrowPcuQf+/Kn
 w+1M83/eJvfXrJmXFh37ngN0/I5n2t0YVcFirPRWZeFKtH4Oq9wUkSpM0Dn9ttCDu3DV
 Wi/CbiDz4+1jT5UBuRsoTaHKCG30B7fhsLxNBQkcP6JRcN7P8Q8GpifhydzBmKZeUbkQ
 5N4eht1n4qJ70vOsGaginLquOSnkovuT4ervyJuRnQ1BSfq+M+lDFdfemj0HozYBnnzG
 i91cbUhDTLQgeqGUT1VHJ+SXADafn8WcUXtg44wVjcjAM2Gb+4+UHGnKFAwWociQBsS7
 kiPw==
X-Gm-Message-State: AC+VfDz+2ATEwT5mfjBcI3n1hxgOMTXigkVXGORhXjzZZz2ZLVaJM22F
 WiSJunUzQ1r4dSaxqzAIUHOWivnGQT3N9KQxYG7N8UTZffU0B4I8dbklx1Km/LDX6ZohVGM+BOn
 DUu7RB/gnJb3h7ec=
X-Received: by 2002:a17:907:60d5:b0:973:91f7:508a with SMTP id
 hv21-20020a17090760d500b0097391f7508amr7152657ejc.4.1685978983227; 
 Mon, 05 Jun 2023 08:29:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HyyF6QZTwt0jn2OrFZ2f5WKEl2Z8MV2/PmII856UDo/4dNLuQXWm1OKmhT16x9OXSPL0cug==
X-Received: by 2002:a17:907:60d5:b0:973:91f7:508a with SMTP id
 hv21-20020a17090760d500b0097391f7508amr7152639ejc.4.1685978982899; 
 Mon, 05 Jun 2023 08:29:42 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 k16-20020a1709065fd000b00977db7d08cbsm1243424ejv.74.2023.06.05.08.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 08:29:42 -0700 (PDT)
Message-ID: <3d543243-c5b4-2e3a-8a8b-7dccefd186c4@redhat.com>
Date: Mon, 5 Jun 2023 17:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Fix venv issues with Avocado by reverting to an older
 version
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, alex.bennee@linaro.org,
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
References: <20230605075823.48871-1-pbonzini@redhat.com>
 <CAFEAcA8fRWdFMrcy6G6yT-8320UZUf6QA9XO70f7P1ssraedRQ@mail.gmail.com>
 <814834c9-b257-8cdb-7372-35e689bc37ac@redhat.com>
 <CAFEAcA-8rz_RXwfnxGE9spFrqdZNU5tp52Hnik-phUH0oUEwMA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA-8rz_RXwfnxGE9spFrqdZNU5tp52Hnik-phUH0oUEwMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/5/23 12:58, Peter Maydell wrote:
> On Mon, 5 Jun 2023 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 6/5/23 11:46, Peter Maydell wrote:
>>>> To avoid this issue, tests/requirements.txt should use a ">=" constraint
>>>> and the version of Avocado should be limited to what distros provide
>>>> in the system packages.  Only Fedora has Avocado, and more specifically
>>>> version 92.0.  For now, this series reverts to the older requirement
>>>> (version >=88.1) while leaving further version bumps to future changes.
>>> If the new Avocado version is broken, don't we also need a < constraint
>>> so we don't get it by mistake ?
>>
>> I expected those to be bugs that get fixed in 102 or 101.1, so not a
>> reason to impose a strict constraint.  But you're right, the version
>> that would be installed from PyPI is the latest; I didn't notice because
>> I do have avocado installed outside pyvenv/.
>>
>> Is the logging issue limited to the one fixed by
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg962758.html?  Or
>> is there something more?
> 
> I don't know, as I haven't tested with that patch.
> 
>>> In particular, for a local build tree that currently has 101 installed,
>>> if the tree is updated to include these two patches together, will that
>>> correctly downgrade it to 88.1?
>>
>> No, it won't.  What you can do is "pyvenv/bin/pip uninstall
>> avocado-framework".
> 
> I think if we're going to revert back from Avocado 101 we should
> actively do that, not merely allow older versions.

I think for now I can revert 9c6692db550f739a84fe4b677428df09d9fafdc3 
too (which will have the side effect of reverting to the older version) 
together with the first patch.

Paolo


