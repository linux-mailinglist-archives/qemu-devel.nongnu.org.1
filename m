Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4A7BBE16
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 19:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qop3I-0003lT-Gj; Fri, 06 Oct 2023 13:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qop3G-0003lL-HL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qop3E-0004Nn-Pr
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 13:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696614947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SFKN4iezE0ksIieepeZiMZbHV6maIs+ErDXqQ6IdG8k=;
 b=iKtSpC+Bg9LP9fZGAMy5TIiMoMR0Wg35DzYdyo9eaE6VI/UiBS7nVraHncHxVJjNiOHzRP
 aOukmtTiAwy1GTSOFHOGFoNn14IDdM10zcWTu/r34EvEJugzq9qaspd8xVltTT9WYeYcxA
 A8Vz44iplOEH4Yvi96529bso6TxgvMY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-xzjz5TzwOpSJ2LEXL2pnSQ-1; Fri, 06 Oct 2023 13:55:36 -0400
X-MC-Unique: xzjz5TzwOpSJ2LEXL2pnSQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1dce198f501so3462772fac.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 10:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696614936; x=1697219736;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SFKN4iezE0ksIieepeZiMZbHV6maIs+ErDXqQ6IdG8k=;
 b=W7R73lloIO6tFyfEHLvrcimhNFkhw6lSYcmcPJ6ukV1T6AQSbI29Q0CWdgxm7WUCOg
 gdTLYAfxbay+CjYpRFyVVeaYssAAz7l9VF93yP3N1Tl7cLbdrMiaFxoiTOphB9RCVU03
 H/MuCmM9jrK++Vw1OkUSxFv6zzg0BewXm8Y0yFpSfHZdlHaGwc2jFqwUWmt8i3oAxvBL
 EIdVn3hkjSSiXrJbOkYEd5W+1KDUNYMfJfMnNIEC7owRsvKbq8wC7AUgkAy2JmhyYB98
 LPR7jRP1ICUqPpvTDg0YpWqO2ML3zyqoYOHzQ7oKGcrT7Ouq21pOFB1O15k3Ikhpfbtv
 cEvg==
X-Gm-Message-State: AOJu0YywwmqonbCYBMhyzev9ntWiXDYjB4IIP5KIh/JfcbL6DBtbw5gu
 N7OjBOCGjuH02vy65bmkOShcxKkYDyZmht0iCP2OtCGC5hjnPqbZub8iDYOetWllsSbh97c0FiX
 YlQwASbLgQENy2Yw=
X-Received: by 2002:a05:6870:2381:b0:1bb:99fe:6ad1 with SMTP id
 e1-20020a056870238100b001bb99fe6ad1mr9720923oap.6.1696614935846; 
 Fri, 06 Oct 2023 10:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr05GdB0iPnqM8GU49oEf/bRJIW7EJ55SmLYde0N0fCNZZQWW9jJZZpGriaN1RdBGtzV9uPQ==
X-Received: by 2002:a05:6870:2381:b0:1bb:99fe:6ad1 with SMTP id
 e1-20020a056870238100b001bb99fe6ad1mr9720908oap.6.1696614935508; 
 Fri, 06 Oct 2023 10:55:35 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 f26-20020a05620a12fa00b007758aad4b64sm1475366qkl.9.2023.10.06.10.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 10:55:35 -0700 (PDT)
Message-ID: <884f4d8c-4ee4-3ee2-ff62-5d7166a75adb@redhat.com>
Date: Fri, 6 Oct 2023 19:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [v3] Help wanted for enabling -Wshadow=local
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Warner Losh <imp@bsdimp.com>
References: <87mswvg683.fsf@pond.sub.org>
 <12397ede-8e20-cb55-b759-d2fbf7732f46@redhat.com>
In-Reply-To: <12397ede-8e20-cb55-b759-d2fbf7732f46@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 06/10/2023 18.18, Thomas Huth wrote:
> On 06/10/2023 16.45, Markus Armbruster wrote:
>> Local variables shadowing other local variables or parameters make the
>> code needlessly hard to understand.  Bugs love to hide in such code.
>> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
>> on polling error".
>>
>> Enabling -Wshadow would prevent bugs like this one.  But we have to
>> clean up all the offenders first.
>>
>> Quite a few people responded to my calls for help.  Thank you so much!
>>
>> I'm collecting patches in my git repo at
>> https://repo.or.cz/qemu/armbru.git in branch shadow-next.  All but the
>> last two are in a pending pull request.
>>
>> My test build is down to seven files with warnings.  "[PATCH v2 0/3]
>> hexagon: GETPC() and shadowing fixes" takes care of four, but it needs a
>> rebase.
>>
>> Remaining three:
>>
>>      In file included from ../hw/display/virtio-gpu-virgl.c:19:
>>      ../hw/display/virtio-gpu-virgl.c: In function ‘virgl_cmd_submit_3d’:
>>      /work/armbru/qemu/include/hw/virtio/virtio-gpu.h:228:16: warning: 
>> declaration of ‘s’ shadows a previous local [-Wshadow=compatible-local]
>>        228 |         size_t 
>> s;                                                       \
>>            |                ^
>>      ../hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of macro 
>> ‘VIRTIO_GPU_FILL_CMD’
>>        215 |     VIRTIO_GPU_FILL_CMD(cs);
>>            |     ^~~~~~~~~~~~~~~~~~~
>>      ../hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declaration 
>> is here
>>        213 |     size_t s;
>>            |            ^
>>
>>      In file included from ../contrib/vhost-user-gpu/virgl.h:18,
>>                       from ../contrib/vhost-user-gpu/virgl.c:17:
>>      ../contrib/vhost-user-gpu/virgl.c: In function ‘virgl_cmd_submit_3d’:
>>      ../contrib/vhost-user-gpu/vugpu.h:167:16: warning: declaration of ‘s’ 
>> shadows a previous local [-Wshadow=compatible-local]
>>        167 |         size_t 
>> s;                                               \
>>            |                ^
>>      ../contrib/vhost-user-gpu/virgl.c:203:5: note: in expansion of macro 
>> ‘VUGPU_FILL_CMD’
>>        203 |     VUGPU_FILL_CMD(cs);
>>            |     ^~~~~~~~~~~~~~
>>      ../contrib/vhost-user-gpu/virgl.c:201:12: note: shadowed declaration 
>> is here
>>        201 |     size_t s;
>>            |            ^
>>
>>      ../contrib/vhost-user-gpu/vhost-user-gpu.c: In function 
>> ‘vg_resource_flush’:
>>      ../contrib/vhost-user-gpu/vhost-user-gpu.c:837:29: warning: 
>> declaration of ‘i’ shadows a previous local [-Wshadow=local]
>>        837 |             pixman_image_t *i =
>>            |                             ^
>>      ../contrib/vhost-user-gpu/vhost-user-gpu.c:757:9: note: shadowed 
>> declaration is here
>>        757 |     int i;
>>            |         ^
>>
>> Gerd, Marc-André, or anybody else?
>>
>> More warnings may lurk in code my test build doesn't compile.  Need a
>> full CI build with -Wshadow=local to find them.  Anybody care to kick
>> one off?
> 
> I ran a build here (with -Werror enabled, so that it's easier to see where 
> it breaks):
> 
>   https://gitlab.com/thuth/qemu/-/pipelines/1028023489
> 
> ... but I didn't see any additional spots in the logs beside the ones that 
> you already listed.

After adding two more patches to fix the above warnings, things look pretty 
good:

  https://gitlab.com/thuth/qemu/-/pipelines/1028413030

There are just some warnings left in the BSD code, as Warner already 
mentioned in his reply to v2 of your mail:

  https://gitlab.com/thuth/qemu/-/jobs/5241420713

  Thomas


