Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D37EE4A6
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ebo-0005q0-TF; Thu, 16 Nov 2023 10:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3ebl-0005pe-9T
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3ebj-0004iP-ME
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700149722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PncKhv7RlipPGQAqM/anQZy5pF106X6pETcgPdX4raM=;
 b=ECqDV5SwUFQV+w1ccavyIX/lSsli6yOwLpuNXvfL93ORj1lYoWpK6bjg+ZnMktiGjh4pqk
 DzAiPy1fG71zdB7YNmVsrjqJB48XK8coS8YMS9TOb2FCyKOrqGHu8EhlyU7TMnd3VA8Hb1
 XgQpDA6vcyrmB2c6GPvIDv3YqCUQ4Ho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Yg6eWlmFPLKMVyLX_bq4Fw-1; Thu, 16 Nov 2023 10:48:41 -0500
X-MC-Unique: Yg6eWlmFPLKMVyLX_bq4Fw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32fd5f7b674so440230f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 07:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149720; x=1700754520;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PncKhv7RlipPGQAqM/anQZy5pF106X6pETcgPdX4raM=;
 b=DoVbI6aBVDlz3MiyMIBLwOl8saGJvbIKqz7mVcrucVmyvKNrcYMnKdMzpPdKCveHkh
 LiJQSeA1Y6I5HnHZRHRY5zYCfR/eN+WlF5GLBloqWNfGB6gk8IAj/gXP6IUbP57PBr63
 xpmCx39V3ExkQNhOH+xixbP5XTOB2cAXfxJO/oTMRljMvtFDvBu7ij1pFYAnypQJtfm/
 64mr1mjvdlgO9EMuhlFZNGICSo60nN0OfJvxY4e/14dSIRXbkIqVPxCGxzyAd/57uqnS
 OPuIK+4QcZS85HDQySW4hVxb8xwq2QvlBgTyZOnJA20a6l2bq/xGfh94bWCRO+iNNkp0
 vd+Q==
X-Gm-Message-State: AOJu0Yzp3XXa9Z1oTDEb1SiBLcfTW1P2jC68gT4+kRcreDYt4Owx5QiC
 zybDY6O/VLPk2UKXb0yu3XAtWL4DzYNJLheJge1EoKu4X7MgskBKAfir0jaEZQqjOEDpx+HuqW+
 ZNBfCpRxUcfN+Jb4=
X-Received: by 2002:adf:ea07:0:b0:32d:9b32:8a7e with SMTP id
 q7-20020adfea07000000b0032d9b328a7emr9586643wrm.71.1700149720416; 
 Thu, 16 Nov 2023 07:48:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFac2nQfnvyZPu9OCoRJwdCoFP9DagmaFNfKyEtEYLHOlCY3FhKEua6ToLYQm/ia+uv7r0Grw==
X-Received: by 2002:adf:ea07:0:b0:32d:9b32:8a7e with SMTP id
 q7-20020adfea07000000b0032d9b328a7emr9586621wrm.71.1700149720034; 
 Thu, 16 Nov 2023 07:48:40 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600010cd00b0032db8f7f378sm14080769wrx.71.2023.11.16.07.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:48:39 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Gavin Shan <gshan@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,  Evgeny Iakovlev
 <eiakovlev@linux.microsoft.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH-for-8.2 v4 09/10] hw/char/pl011: Add transmit FIFO to
 PL011State
In-Reply-To: <45ef60fe-dcb6-461d-97e1-d19e5174075d@linaro.org> (Richard
 Henderson's message of "Thu, 9 Nov 2023 15:24:16 -0800")
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-10-philmd@linaro.org>
 <45ef60fe-dcb6-461d-97e1-d19e5174075d@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 16 Nov 2023 16:48:38 +0100
Message-ID: <87o7fthf6x.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 11/9/23 11:28, Philippe Mathieu-Daud=C3=A9 wrote:
>> @@ -436,6 +438,24 @@ static const VMStateDescription vmstate_pl011_clock=
 =3D {
>>       }
>>   };
>>   +static bool pl011_xmit_fifo_state_needed(void *opaque)
>> +{
>> +    PL011State* s =3D opaque;
>> +
>> +    return !fifo8_is_empty(&s->xmit_fifo);
>> +}
>> +
>> +static const VMStateDescription vmstate_pl011_xmit_fifo =3D {
>> +    .name =3D "pl011/xmit_fifo",
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .needed =3D pl011_xmit_fifo_state_needed,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_FIFO8(xmit_fifo, PL011State),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static int pl011_post_load(void *opaque, int version_id)
>>   {
>>       PL011State* s =3D opaque;
>> @@ -487,7 +507,11 @@ static const VMStateDescription vmstate_pl011 =3D {
>>       .subsections =3D (const VMStateDescription * []) {
>>           &vmstate_pl011_clock,
>>           NULL
>> -    }
>> +    },
>> +    .subsections =3D (const VMStateDescription * []) {
>> +        &vmstate_pl011_xmit_fifo,
>> +        NULL
>> +    },
>>   };
>
> It just occurred to me that you may need a vmstate_pl011 pre_load() to
> empty the FIFO, which will then be filled if and only if the saved
> vmstate_pl011_xmit_fifo subsection is present.
>
> Juan, have I got this correct about how migration would or should handle =
a missing subsection?

I hav'nt looked about how the device is created. But if it is created
with the fifo empty you don't need the pre_load().

I have no idea about this device, but sometimes it just happens that if
the fifo has data, you need to put an irq somewhere or mark it some
place that there is pending job on this device.

Later, Juan.


