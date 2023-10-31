Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC67DCF4B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:34:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpov-0001dT-Ur; Tue, 31 Oct 2023 10:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxpou-0001cm-Af
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxpor-00006W-4o
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698762852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7wyPjsxNB6yPcrYuMxtYd0W9Dm6ET1xOzaurPYBLlU=;
 b=Oso8BNlu1vfzOKef/NeCW/OsJEMzFGReO6oZ7M53EUGudRtitinw+lBqzgILyZ7BTLKIuA
 EZJwiR2fJVobQcDbW5z79b38/a3aBVDX7VLdII9dKt9HBVK+hEifCnFlJueCHgNSd16qdx
 6dL8xUMhGJvkNTN9mMSqLVl8JfTpoIs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-rQ-nHhiCMZuV3HPfUpaPpw-1; Tue, 31 Oct 2023 10:33:55 -0400
X-MC-Unique: rQ-nHhiCMZuV3HPfUpaPpw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407d3e55927so39370405e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762834; x=1699367634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x7wyPjsxNB6yPcrYuMxtYd0W9Dm6ET1xOzaurPYBLlU=;
 b=M+GXPzEZFJrRpqZS605DBRSjWLzQ/vccTJMyD3C0hqKVF6W3G/giVMDbqn9pfxh24c
 QkpuUJ+ZUT+73le5hnXPzS0Rv4FQSH5eg/MBZRf1+CosotzqJuFZoy3cN/YB1pXYq8za
 yPZFfzuf+MV28spygBx0MNDJc6uHQde6SxBh4jgd9SGpWgjNtWxqPG5DybZ3TKb8TjX9
 Nb+I9oBzfSdoUXPTGejoXOATmZ8BPZ4SRXm8+nB7BVRj2akwv5ZQJjIIS/sDJ6vZWM+2
 RjXIfTH5oS9y5MFvTfEwLg7EDVlJq9LXx1WsfM658q48g0mlYqOWiTGjY0wsszGyp49O
 EYoQ==
X-Gm-Message-State: AOJu0Yx10SqXz06r5xQSCRhdZf1s0f0GTCBwQkXtSJLgIvaukXwkLTci
 VMi64m8FtIWQLG2eqMMIh4pP//lKsJ0f3Q2cw5GDBH+ckj0pHWA2NIEatAR0rEYL5JBWbtHHg4W
 UO8jZWFATD0feVdI=
X-Received: by 2002:a5d:584e:0:b0:32f:9268:be5c with SMTP id
 i14-20020a5d584e000000b0032f9268be5cmr2653312wrf.56.1698762834285; 
 Tue, 31 Oct 2023 07:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrQibvTiTkfuta2i02Qt+aoYDXe1Gx9btxkpR4W2YOWsbn6QdLAhI7aLQ7100DSIUJAE8zig==
X-Received: by 2002:a5d:584e:0:b0:32f:9268:be5c with SMTP id
 i14-20020a5d584e000000b0032f9268be5cmr2653290wrf.56.1698762833912; 
 Tue, 31 Oct 2023 07:33:53 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600000ce00b00326b8a0e817sm1623443wrx.84.2023.10.31.07.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 07:33:53 -0700 (PDT)
Message-ID: <5f3a8585-18ed-4e05-ac6b-ac21178dfe79@redhat.com>
Date: Tue, 31 Oct 2023 15:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] qemu-img: do not erase destination file in
 qemu-img dd command
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>,
 Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 den@openvz.org
References: <20230930203157.85766-1-mike.maslenkin@gmail.com>
 <15609bb5-95d0-3d38-4c44-bcd313dc723b@virtuozzo.com>
 <CAL77WPAHSG-B3J_G8JzJHS5OhjsnsDs_wjYyGyPcBbeyS0z8=A@mail.gmail.com>
 <d29be9a0-3765-10b1-24f1-6aa053e4213f@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <d29be9a0-3765-10b1-24f1-6aa053e4213f@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.10.23 22:46, Denis V. Lunev wrote:
> Can you please not top-post. This makes the discussion complex. This
> approach is followed in this mailing list and in other similar lists
> like LKML.
>
> On 10/1/23 19:08, Mike Maslenkin wrote:
>> I thought about "conv=notrunc", but my main concern is changed virtual
>> disk metadata.
>> It depends on how qemu-img used.
>> May be I followed to wrong pattern, but pros and cons of adding "conv"
>> parameter was not in my mind in scope of the first patch version.
>> I see 4 obvious ways of using `qemu-img dd`:
>> 1. Copy virtual disk data between images of same format. I think disk
>> geometry must be preserved in this case.
>> 2. Copy virtual disk data between different formats. It is a valid
>> pattern? May be `qemu-img convert` should to be used instead?
>> 3. Merge snapshots to specified disk image, i.e read current state and
>> write it to new disk image.
>> 4. Copy virtual disk data to raw binary file. Actually this patch
>> breaks 'dd' behavior for this case when source image is less (in terms
>> of logical blocks) than existed raw binary file.
>>      May be for this case condition can be improved to smth like
>>     if (strcmp(fmt, "raw") || !g_file_test(out.filename,
>> G_FILE_TEST_EXISTS)) . And parameter "conv=notrunc" may be implemented
>> additionally for this case.
> My personal opinion is that qemu dd when you will need to
> extract the SOME data from the original image and process
> it further. Thus I use it to copy some data into raw binary
> file. My next goal here would add ability to put data into
> stdout that would be beneficial for. Though this is out of the
> equation at the moment.
>
> Though, speaking about the approach, I would say that the
> patch changes current behavior which is not totally buggy
> under a matter of this or that taste. It should be noted that
> we are here in Linux world, not in the Mac world where we
> were in position to avoid options and selections.
>
> Thus my opinion that original behavior is to be preserved
> as somebody is relying on it. The option you are proposing
> seems valuable to me also and thus the switch is to be added.
> The switch is well-defined in the original 'dd' world thus
> either conv= option would be good, either nocreat or notrunc.
> For me 'nocreat' seems more natural.
>
> Anyway, the last word here belongs to either Hanna or Kevin ;)

Personally, and honestly, I see no actual use for qemu-img dd at all, 
because we’re trying to mimic a subset of an interface of a rather 
complex program that has been designed to do what it does. We can only 
fail at that.  Personally, whenever I need dd functionality, I use 
qemu-storage-daemon’s fuse export, and then use the actual dd program on 
top.  Alternatively, qemu-img convert is our native interface; 
unfortunately, its feature set is lacking when compared to qemu-img dd, 
but I think it would be better to improve that rather than working on 
qemu-img dd.

I tend to agree with you, Denis, though, that this patch changes 
behavior, and users may be relying on the current behavior.

Comparing to “what would dd do” is difficult because dd just has no 
concept of file formats.  (That’s another reason why I think it’s bad to 
provide a dd-like interface, and users should rather use dd itself, or 
qemu-img convert.)  But in any case, adding conv=notrunc to keep the 
existing target file would seem fair to me.  I understand conv=nocreat 
would advise dd to never create the target file, which is something 
slightly different (i.e. conv=notrunc will still create a new target 
file if it doesn’t exist yet, but won’t create/truncate one if it 
already exists; while conv=nocreat would disable creating a new target 
file if it doesn’t exist yet, but still truncate it if it does exist; 
using both together would ensure that the target file is never 
created/truncated).

Summary: If we do this under a new conv=notrunc, fine with me.  I just 
don’t think qemu-img dd is something that should be used at all.

Hanna


