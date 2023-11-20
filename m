Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B9C7F1280
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 12:54:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r52qs-0002gY-Pe; Mon, 20 Nov 2023 06:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r52qp-0002fw-FF
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:54:03 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r52qn-0000du-45
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 06:54:03 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cb4d366248so1270939b3a.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 03:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700481239; x=1701086039;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pIXBCW/2S83I2E23il7vVJbpkH1Cf0lpEQe1YrqR8yY=;
 b=TdPzUSJz6lhx4EkloiGa4V9d44ypln3JPitxvXE9M/jskfcJ3eY+xSGXEmr1mlzCYk
 f3j8eUwxLw8DWi8wtK2u5USN4rrhw9bDN0mQV3aJ7O4UjXAwdHEXHIOsKzsLcfzttQTY
 Ras+dHOqxTDZ9YcLclp88t8sDzZgbKZPtIBhHQ/30mjmDEEHGCrYOKPah+3stRjttn25
 SyjKGl+FLhQtSCsGiORoCt12+a3v7gFvhGqZ+uoBvGPT3PsRc3QbURNbVAlYTQwaGLvX
 PKRXlhyivzXiwc5zdDNM0NYYx4SK/GSLCJ753bsTimD86NEuNZnVn4qJBKkEycHrWHng
 ZTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700481239; x=1701086039;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIXBCW/2S83I2E23il7vVJbpkH1Cf0lpEQe1YrqR8yY=;
 b=Yjm5Q6uMb0fihDykf8PcrUhW9daAkXdbwl/aEpgmvGEKbYveHrRQUYHiKTQ9BX0EGf
 //+KSSvMiI6D05aRrNk/qtYDR7m5T9pZja4k6A4lFMmnh04jwaMwo6alns2VYDiITu9z
 Pz3jH/HgyfHj8Byl+sy7ToWiwkOn2dd4Dtnh1my5DpAGCSAoPp46sJ5m2YveTu1B7cuJ
 fiy94RIjBwBToEmAyGCO+VFigXvsDXHNEHYllYtLzz3ztzR7FbG6wpkJzAWNulZRg+U4
 EavyRAQbDq3Ua+GH1weiItJJKPMZf5bBP5o7cKcK8ixnEWuRr77JM0vrA3VS9TAs17An
 c2/A==
X-Gm-Message-State: AOJu0YyRMEI3xb8NmTm23RND7YyqjKumskPAz43soSTbke3ZwCTBIIMp
 LYhGIezHGzA8jP449n4bFH0fGg==
X-Google-Smtp-Source: AGHT+IG2xioZozPxDb380Q7faFQSc9Ku6wwlqhbP41RYGe3Nc5a+1miVMCX+yhu3Lx0jgA4Qo1JHtw==
X-Received: by 2002:a05:6a21:a59b:b0:187:7590:7f11 with SMTP id
 gd27-20020a056a21a59b00b0018775907f11mr6699795pzc.43.1700481238934; 
 Mon, 20 Nov 2023 03:53:58 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a001b00b0028398de505dsm5967368pja.48.2023.11.20.03.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 03:53:58 -0800 (PST)
Message-ID: <cbb32a8b-b72c-46fc-ac12-e2252857bca4@daynix.com>
Date: Mon, 20 Nov 2023 20:53:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audio: Free consumed default audio devices
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20231120112804.9736-1-akihiko.odaki@daynix.com>
 <CAJ+F1C+p87y5b23x87W-rVm8a9Y9UqDiPd_HsfhkGtYffZ3ksQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1C+p87y5b23x87W-rVm8a9Y9UqDiPd_HsfhkGtYffZ3ksQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/20 20:35, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Nov 20, 2023 at 3:29 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Failed default audio devices were removed from the list but not freed,
>> and that made LeakSanitizer sad. Free default audio devices as they are
>> consumed.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
>> ---
>> V1 -> V2: Set s->dev NULL after free (Marc-André Lureau)
>>
>>   audio/audio.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index f91e05b72c..8d1e4ad922 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -1758,12 +1758,15 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
>>                   goto out;
>>               }
>>               s->dev = dev = e->dev;
>> +            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
>> +            g_free(e);
>>               drvname = AudiodevDriver_str(dev->driver);
>>               driver = audio_driver_lookup(drvname);
>>               if (!audio_driver_init(s, driver, dev, NULL)) {
> 
> Maybe it would be clearer/safer to set s->dev in audio_driver_init() on success.

I considered that too, but I decided not to that because 
audio_driver_init() takes s and may expect s->dev is initialized.

