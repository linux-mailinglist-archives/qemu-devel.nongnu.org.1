Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869D185C1DE
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 17:58:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcTRT-0006aO-AD; Tue, 20 Feb 2024 11:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcTRR-0006YR-AB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:58:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcTRP-0005nM-Rn
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708448278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dHgN6htehbmvvuZDouHWcpAbMHuaC2OA4OJX2O18mLw=;
 b=aSOajWV4dup+2cNe7Azyd2stSjNCxbQCo6el/k9P2bNYCdcI0tmxa1KDLcIlX99ytDj1ri
 TDMHkvg8PSLc/ojfXXzgdRWNnejO9p6CIJlb4cQR1psiMiDwhZtPpoBGtDtbmbx28KDw1s
 zjUk86TgaelOZrrdcIAIDOPOLqM506c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-qg5XisXLPnqYOPKjmz9H7g-1; Tue, 20 Feb 2024 11:57:55 -0500
X-MC-Unique: qg5XisXLPnqYOPKjmz9H7g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7816e45f957so765037485a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708448275; x=1709053075;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dHgN6htehbmvvuZDouHWcpAbMHuaC2OA4OJX2O18mLw=;
 b=T4Rr2ZgjYBg65Uw19vR14fHZ5EIQxy2DwwjjYvF+kDgX5IdKomJBak8SbsdviqBOSA
 20SafrT7CJYKFcrFvCfKgR3dEDo27psZ+hX86ttkygWRGdyjy6BzE5yH96Z0eiPDzips
 PKm/zeECsxCqdeyVfVAOISIsToJmZsg9gT60KFkqMdT+kWpugkk0JEUVKdH7tXacjA/i
 R+fYs0RBFJ95ZYfaNKJL/xYI0gYGuJEbZKFC+dV9xkY08t6VXMB4Z+IG2azrtBI25rH1
 znAK41Y4E+SMEhYhtk6aRYx2StxUcw4M05bzfUTttEayLElSKceA4Pog2i+i5JfETdES
 gJMA==
X-Gm-Message-State: AOJu0YyR65/zHGRQhEdJRKfK7TrKqBOjQG3WhvD03iCmCzXdIQrEkBjh
 L+vFmgxcIOW57teAWlR3R3wqAEfmOVljby53ycaC5ms91auF9lZyasAQ8edphrsV5XDYxvi32Qb
 8tMxnJ7Bz+etvw7mCGP6QF/pHP1K0WG/tUqexh70U9rYq0bB2eOxL
X-Received: by 2002:a05:620a:3846:b0:785:9506:213b with SMTP id
 po6-20020a05620a384600b007859506213bmr15273432qkn.73.1708448275275; 
 Tue, 20 Feb 2024 08:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8CPnk2cW+8w3lwkw2imlhyySrtW5tzWrpmVeilzyOkvxK/w63dKJG6Gr5oAgoRaURFIeeAA==
X-Received: by 2002:a05:620a:3846:b0:785:9506:213b with SMTP id
 po6-20020a05620a384600b007859506213bmr15273420qkn.73.1708448275010; 
 Tue, 20 Feb 2024 08:57:55 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 x18-20020a05620a099200b0078728331477sm3535890qkx.13.2024.02.20.08.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 08:57:54 -0800 (PST)
Message-ID: <0ab9b9ce-9327-4112-bb7e-ad191353ccea@redhat.com>
Date: Tue, 20 Feb 2024 17:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Don't run the dbus-display-test without
 CONFIG_VGA_PCI
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20240219123900.430943-1-thuth@redhat.com>
 <CAMxuvazmk_cnxUOAsAi1D7=VsT7OkkyNPL6adqqCkwt2LWVscg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAMxuvazmk_cnxUOAsAi1D7=VsT7OkkyNPL6adqqCkwt2LWVscg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 19/02/2024 15.00, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Feb 19, 2024 at 4:39 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> When compiling with "configure --without-default-devices", the
>> dbus-display-test fails since it implicitly assumes that the
>> machine comes with the standard VGA card. Thus add a check to
>> meson.build to disable the test if the VGA card is not available.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Not necessarily VGA, but a graphic or VC console.

Well, the test currently does not use any -device or -vga options, so it 
assumes that the default graphic card is around - which happens to be the 
VGA_PCI card for x86.

> I am not sure how to
> guess from the binary or compilation settings. Maybe it would be
> simpler to check at run-time if /org/qemu/Display1/Console_0 exists. I
> can work on a patch.

That sounds like a more robust solution indeed, so a patch would be very 
welcome!

  Thanks,
   Thomas


>> ---
>>   tests/qtest/meson.build | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 2b89e8634b..c8e6d7df40 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -108,7 +108,7 @@ qtests_i386 = \
>>      'numa-test'
>>     ]
>>
>> -if dbus_display
>> +if dbus_display and config_all_devices.has_key('CONFIG_VGA_PCI')
>>     qtests_i386 += ['dbus-display-test']
>>   endif
>>
>> --
>> 2.43.2
>>
> 


