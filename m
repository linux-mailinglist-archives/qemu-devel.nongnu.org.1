Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 365207E2AFA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:32:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03R0-0006aH-SO; Mon, 06 Nov 2023 12:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r03Qz-0006Zp-Ec
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:30:45 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r03Qw-0003YS-Jn
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:30:45 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c509d5ab43so68629701fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699291840; x=1699896640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxdhObm1sp48iu6eLoDhPq+6n5vWViWaHUNDRN7U0ck=;
 b=DrZWQ1WC/LgZk2UFBn6sG3IrCtfnaXrnGc2fLL9co5CJm4kpTl6TURlaFnlEJSjQMB
 g16Pogpab5Q5Wo/IWzKKS/No8g8uZi7FdFvqGrUhTr3T3MjS0ITFB5Dtm2KLlXG8C9G/
 Ey6OU2KPMQqCWUNATdr0vs9KnB+PVhMwCq9h0LmyMT3J3zc7eJJVPrvQzxhlIjZz8M1j
 OdkZb5s/8BC4TNj7eZDp/Wz3o68j+1wNQ0TQpGUmelBPcUF690xTnR6zXrGXB6JQakil
 PkIZxxeKbJ54Ij1zWNOR5A5PpM6jkKhSF09qZgkXiQoNR4my2Q7ILnX0zcxcy+7x+riu
 Sj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291840; x=1699896640;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HxdhObm1sp48iu6eLoDhPq+6n5vWViWaHUNDRN7U0ck=;
 b=wFaDUqvFM8QcnMDmxnRnMd0YrhM/GWbgGgB0hH3kC69I0NttQGaBc0XApL9ZeLmaF5
 sp2gsvzgo3/1UF70Cmtc/jcuNO/JiADliIiQv+RZ8XfqAAoSd2SyrweBjfnGoLJNwaML
 DPjnHH9R7qwhkL7f++WTJ+BWF8IMadpoYrfmWWs+TgNI+BB7CZqqgtL36+HDQDnbujx3
 oNibQLXdRo/LDTt+Lnex4GqOYi2AnJ32L1+XVMj/O/AC32VpnG1ujV5fZfsKJAdckdAa
 2k23p1RP6nHfk3MxWvk9RB3PE7Hq2vyqz0WpOicB/VPhQ7a47iCEheyWMCowxVACzPzn
 BUcQ==
X-Gm-Message-State: AOJu0Yy1hsgn0cLFS/+V0CYvJ0VcxAMnxDgoqXOXYV71KKgvYKxDMdJx
 EPB0Pr4MiLbNyr5KBkKfkpausg==
X-Google-Smtp-Source: AGHT+IH3wr3zQHwoYFL2MXImNsR89qzFvJon97Se10Rv/G+6DE1r3LeJuX/UOR2DxeVnZ1HKdGuDCg==
X-Received: by 2002:a05:651c:1052:b0:2c5:1045:71cb with SMTP id
 x18-20020a05651c105200b002c5104571cbmr21410675ljm.32.1699291840472; 
 Mon, 06 Nov 2023 09:30:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 du15-20020a05600c634f00b00405959bbf4fsm12585358wmb.19.2023.11.06.09.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:30:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF24D65565;
 Mon,  6 Nov 2023 17:30:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 virtio-fs@redhat.com,  Eduardo Habkost <eduardo@habkost.net>,  Fam Zheng
 <fam@euphon.net>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Erik Schilling <erik.schilling@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,  Eric Blake <eblake@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Raphael
 Norwitz <raphael.norwitz@nutanix.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v5 3/6] hw/virtio: derive vhost-user-gpio from
 vhost-user-base
In-Reply-To: <20231106121400-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Mon, 6 Nov 2023 12:15:11 -0500 (14 minutes, 20
 seconds ago)")
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-4-alex.bennee@linaro.org>
 <20231106121400-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 06 Nov 2023 17:30:39 +0000
Message-ID: <87ttpybxhc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Oct 19, 2023 at 10:56:07AM +0100, Alex Benn=C3=A9e wrote:
>> Now the new base class supports config handling we can take advantage
>> and make vhost-user-gpio a much simpler boilerplate wrapper. Also as
>> this doesn't require any target specific hacks we only need to build
>> the stubs once.
>>=20
>> Message-Id: <20230418162140.373219-12-alex.bennee@linaro.org>
>> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231009095937.195728-4-alex.bennee@linaro.org>
>> ---
>> -    case CHR_EVENT_OPENED:
>> -        if (vu_gpio_connect(dev, &local_err) < 0) {
>> -            qemu_chr_fe_disconnect(&gpio->chardev);
>> -            return;
>> -        }
>> -        break;
>> -    case CHR_EVENT_CLOSED:
>> -        /* defer close until later to avoid circular close */
>> -        vhost_user_async_close(dev, &gpio->chardev, &gpio->vhost_dev,
>> -                               vu_gpio_disconnect);
>
> Hmm. Looking at this, it seems that the base device will handle close
> synchronously. No? Why isn't this a problem?

I suspect it was a copy and paste from another vhost-user impl. But
testing has shown it works ok.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

