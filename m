Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960317B88B3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6Q5-0007aC-Dl; Wed, 04 Oct 2023 14:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Q3-0007Zv-Sa
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo6Q2-0000iM-G8
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696443381;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaYDzm8PMsdnSj4/6C9guC4B68pIibgtwXlN5vOd0Ug=;
 b=RCNszckur2yF2+vaHFtmuAde32BrANWtge9PaRfs/jlp4aMs+4Dz6IdGEVuUJrKQ34fDHu
 JrNAiPq5gVfIm8w5zkbmAtVCwezYlD6n49Ay2M3+rQp/WIPCQ3Vpj0VZMOi6vQ8oXtLoRa
 kEICo03g2FO3QxoTrA53mVWdIQ4S0nM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-zu63_cG-PWCUn23RYT2rAA-1; Wed, 04 Oct 2023 14:16:20 -0400
X-MC-Unique: zu63_cG-PWCUn23RYT2rAA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405334b0873so879985e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 11:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696443379; x=1697048179;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kaYDzm8PMsdnSj4/6C9guC4B68pIibgtwXlN5vOd0Ug=;
 b=ZSwNwv8eq0PaKiYQiEcxVjEY0RvCOzRO2nibyMjCJdNoQqVJrzXU8OtJm/xMcDW7sy
 mb8/0F+SxzjYLDT/klge08hJ0Y5qIhWuf2sb0Zs6bnb5WfCcVZB2eOBB60NwhsLQgX/Q
 +Uwo60d482G6GvXnArOR+6Qmf2xtPMHir1Slx17hmagJVuuytCXnlc3x20fnVOXtpJ9N
 USB/28OPyYjww7g5Ckkl7+gzFwGVru0LGSSmLyxSY0rIEiKx/TxZIgC30qDLZt8fiXCQ
 Pa8n8fzbQHggjqh65wUQ9iX2fQVStAQig2R6dMqiF+a4MKi9S1gLkfL954Ajvj2carYN
 r/5w==
X-Gm-Message-State: AOJu0YyG9U1QMdy74zeR/zhQoy6AAl981C+AVAauzM4wmvKt5oZ9SvP/
 CN9mUu6K2BMLO21DjnJdEyA99KVV4xrJ15aMsbqkckkHOiw4zQ/ttnVl3UTNz16rvXbTkBd9xBL
 laC6l6bI8IT4l6sA=
X-Received: by 2002:a7b:cbd4:0:b0:401:b76d:3b8b with SMTP id
 n20-20020a7bcbd4000000b00401b76d3b8bmr3223910wmi.16.1696443379148; 
 Wed, 04 Oct 2023 11:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyyENlewV3mNk4S3Y5/UFWJ+OJ659Sw+75vC7838w5Saxzzn/2GXh32xFL+Ek1II8LnA7sog==
X-Received: by 2002:a7b:cbd4:0:b0:401:b76d:3b8b with SMTP id
 n20-20020a7bcbd4000000b00401b76d3b8bmr3223849wmi.16.1696443378641; 
 Wed, 04 Oct 2023 11:16:18 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c205500b003fefaf299b6sm2099085wmg.38.2023.10.04.11.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 11:16:17 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,  "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Amit
 Shah <amit@kernel.org>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Alberto Garcia <berto@igalia.com>,  Fam Zheng
 <fam@euphon.net>,  John Snow <jsnow@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  =?utf-8?Q?C=C3=A9dric?=
 Le Goater
 <clg@kaod.org>,  David Gibson <david@gibson.dropbear.id.au>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Jason Wang <jasowang@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Konstantin Kostiuk
 <kkostiuk@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Thomas Huth <thuth@redhat.com>,
 integration@gluster.org
Subject: Re: [PATCH 21/21] qapi: Remove 'qapi/qmp/qerror.h' header
In-Reply-To: <20231004173158.42591-22-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Oct 2023 19:31:56
 +0200")
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-22-philmd@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 20:16:17 +0200
Message-ID: <87o7heqmmm.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> This file is now empty. Avoid new definitions by killing it,
> paying off a 8 years old debt (with interests).
>
> Mechanical change using:
>
>   $ git grep -l qapi/qmp/qerror.h | while read f; do \
>       gawk -i inplace '/#include "qapi\/qmp\/qerror.h"/ && !p {p++;next}1=
' $f; \
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>


