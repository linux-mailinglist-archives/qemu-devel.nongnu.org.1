Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0447436BF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:13:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9FX-0006Ni-AR; Fri, 30 Jun 2023 04:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qF9FU-0006Lk-6M
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:13:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qF9FQ-0004qG-Ka
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:12:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3094910b150so1823550f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688112775; x=1690704775;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EK4A9uz8sOJt0OWS6N8Q3vl2hXc7PV98cpikAOQDqGk=;
 b=fngK9xXw9L/tU3Yp9e1XcOVCw5RIEMJC1tUOo4meIePS0t5YLeC3J379I21PenXuVO
 T3HhGNC+hfzKN3Fv3bOEUE2wN0twQJ/4UOy4qa95lSGVbcXPo1F/WrpH/YYZhIt5QqCH
 eZpPjPvn3Vz7DRDo8LdZtvB9AGhvq34oaVuA+tUWNhZKw3Mb5rKfxcCb0EpI1cabbzwQ
 EMubxzbvwZYsFznSxcG7/K4Lb8K/hGjHBSxV38ZxAS0eTTFNTLEBNKJp7K47F/nrfI4y
 0bDQnvI04MNJZVQMHdZ+YAiqMXnbNKcL17hI16Z/wuCG849X7yzNTN9xLr0Ayx6UEMkJ
 bTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688112775; x=1690704775;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EK4A9uz8sOJt0OWS6N8Q3vl2hXc7PV98cpikAOQDqGk=;
 b=hOm+bJ9szhFD2ZIh/xEdKN+Olq5kkMxlVpYGVenvuuGFZyIO8tslgFLu9GXMBr2d22
 g/8789JFejTAv9IfF+9I7OerHU3UfVUV72ezxBq1f0AM7YxApzFSf4PGzybS+6ZelS0a
 qYKXcHRhXb74wE8FICIfEGvKoedkv44liWbriX5pyXTYJZwyyAvVLiPMYf9PPmaEdloH
 qi7KM/uuxNeyuUVcqQLh+SON7Fk/iHMF3Q0y08sm1rCACMh1vr5qYkv8nUiX/BlfwMn4
 BKZWRKzeb4KzYjMnxk6EVQTe691kf7+VYk5KeqKH8bD2nujVRtddH9FxuhgaSm13C3zs
 TdPA==
X-Gm-Message-State: ABy/qLaz13YlsSFZ3vECN3eCnqwxvtVnVvQFMyBm9CYSVKTuHZAhDW3i
 0gmbyypaPEsqcRLBshdIC8ikxg==
X-Google-Smtp-Source: APBJJlFiOrhXPWcR/yc/uUx+TPGTE+FlTRkeIrlhtt5jWkcrwXfO3kCPvzhsdwaJZUcrR+LxoJZ2yQ==
X-Received: by 2002:adf:ff8e:0:b0:314:22f2:8bf7 with SMTP id
 j14-20020adfff8e000000b0031422f28bf7mr846199wrr.56.1688112774760; 
 Fri, 30 Jun 2023 01:12:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a5d498a000000b00314091d58b4sm6733967wrq.18.2023.06.30.01.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 01:12:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EC7011FFBB;
 Fri, 30 Jun 2023 09:12:53 +0100 (BST)
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-26-alex.bennee@linaro.org>
 <b08189c8-38c2-adbf-7bb3-0304f4845fc0@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Juan Quintela <quintela@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Beraldo Leal <bleal@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>, Radoslaw
 Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Bandan Das <bsd@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alexandre
 Iooss
 <erdnaxe@crans.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Laurent Vivier
 <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH v3 25/36] docs/devel: introduce some key concepts for
 QOM development
Date: Fri, 30 Jun 2023 09:03:56 +0100
In-reply-to: <b08189c8-38c2-adbf-7bb3-0304f4845fc0@linaro.org>
Message-ID: <87fs69xta2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 27/6/23 18:09, Alex Benn=C3=A9e wrote:
>> Using QOM correctly is increasingly important to maintaining a modern
>> code base. However the current documentation skips some important
>> concepts before launching into a simple example. Lets:
>>    - at least mention properties
>>    - mention TYPE_OBJECT and TYPE_DEVICE
>>    - talk about why we have realize/unrealize
>>    - mention the QOM tree
>>    - lightly re-arrange the order we mention things
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20230619171437.357374-6-alex.bennee@linaro.org>
>> ---
>> v3
>>    - moved around as per Paolo's review
>> ---
>>   docs/devel/qom.rst | 58 +++++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 52 insertions(+), 6 deletions(-)
>
>
>> +Creating a QOM class
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +A simple minimal device implementation may look something like bellow:
>>     .. code-block:: c
>>      :caption: Creating a minimal type
>> @@ -48,6 +66,12 @@ In the above example, we create a simple type that is=
 described by #TypeInfo.
>>   #TypeInfo describes information about the type including what it inher=
its
>>   from, the instance and class size, and constructor/destructor hooks.
>>   +The TYPE_DEVICE class is the parent class for all modern devices
>> +implemented in QEMU and adds some specific methods to handle QEMU
>> +device model. This includes managing the lifetime of devices from
>> +creation through to when they become visible to the guest and
>> +eventually unrealized.
>
> Good enough but we are mixing QOM vs QDev...

Yeah, but one relies on the other. From the point of view of someone
coming new to the code I think we do want to mention them both together.
Most people implementing QOM classes will be for devices I think.

Maybe we should enumerate all the types that have TYPE_OBJECT as their
parent?

>
>>   Alternatively several static types could be registered using helper ma=
cro
>>   DEFINE_TYPES()
>
>
>> +.. _device-life-cycle:
>> +
>> +Device Life-cycle
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +As class initialisation cannot fail devices have an two additional
>> +methods to handle the creation of dynamic devices. The ``realize``
>> +function is called with ``Error **`` pointer which should be set if
>> +the device cannot complete its setup. Otherwise on successful
>> +completion of the ``realize`` method the device object is added to the
>> +QOM tree and made visible to the guest.
>> +
>> +The reverse function is ``unrealize`` and should be were clean-up
>> +code lives to tidy up after the system is done with the device.
>
> Worth mentioning hotplug devices must implement it?
>
>> +All devices can be instantiated by C code, however only some can
>> +created dynamically via the command line or monitor.
>>   +Likewise only some can be unplugged after creation and need an
>> +explicit ``unrealize`` implementation.
>
> Ah, here we go.
>
>> This is determined by the
>> +``user_creatable`` variable in the root ``DeviceClass`` structure.
>> +Devices can only be unplugged if their ``parent_bus`` has a registered
>> +``HotplugHandler``.
>
> TODO on top, mentions the reset() handlers are called after realize(),
> and can be called multiple times.

Where is this TODO? I'm wary of talking about reset too much as the old
reset handler is a deprecated API.

>
>>   API Reference
>> --------------
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>     See the :ref:`QOM API<qom-api>` and :ref:`QDEV API<qdev-api>`
>>   documents for the complete API description.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

