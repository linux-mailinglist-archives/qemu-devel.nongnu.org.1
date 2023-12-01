Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAEC80078F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:51:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90B7-0003hv-NJ; Fri, 01 Dec 2023 04:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r90B4-0003f9-9N
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:51:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r90Aw-0000gs-DO
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701424266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SukUUYxwL8xU7y9ZcoV7Cq5tLyRcFGVgvTR06VdyRjg=;
 b=HI5DAdpy4DH3og58AzXBgHYoznZIUeXp0bdB8beBiW9ClBtEt0mVL/i/JTxnRZZNikNTaF
 hKR2VBkT5+f9CZXWigSMhZGpNTcCaxfTQfz+aVPs1q5fhyRseWZnfM9s8EY1rm3+zvqgal
 p0JoidPAbs+vtBprx6R016miGAmwljo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-VIOtqgowNpSY11b4kOM_vw-1; Fri, 01 Dec 2023 04:51:02 -0500
X-MC-Unique: VIOtqgowNpSY11b4kOM_vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 065128007B3;
 Fri,  1 Dec 2023 09:51:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 865AB1C060AE;
 Fri,  1 Dec 2023 09:51:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E4EA21E6A1F; Fri,  1 Dec 2023 10:51:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  crosa@redhat.com,  bleal@redhat.com,
 eblake@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 alxndr@bu.edu,  bsd@redhat.com,  stefanha@redhat.com,  thuth@redhat.com,
 darren.kenny@oracle.com,  Qiuhao.Li@outlook.com,  lvivier@redhat.com
Subject: Re: [PATCH v6 4/4] scripts: add script to compare compatible
 properties
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-5-davydov-max@yandex-team.ru>
Date: Fri, 01 Dec 2023 10:51:00 +0100
In-Reply-To: <20231108153827.39692-5-davydov-max@yandex-team.ru> (Maksim
 Davydov's message of "Wed, 8 Nov 2023 18:38:27 +0300")
Message-ID: <87o7faxncr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Review, anyone?

Maksim Davydov <davydov-max@yandex-team.ru> writes:

> This script runs QEMU to obtain compat_props of machines and default
> values of different types of drivers to produce comparison table. This
> table can be used to compare machine types to choose the most suitable
> machine or compare binaries to be sure that migration to the newer version
> will save all device properties. Also the json or csv format of this
> table can be used to check does a new machine affect the previous ones by
> comparing tables with and without the new machine.
>
> Default values (that will be used without machine compat_props) of
> properties are needed to fill "holes" in the table (one machine has
> the property but another machine not. For instance, 2.12 machine has
> `{ "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" }`, but compat_pros of
> 3.1 machine doesn't have it. Thus, to compare these machines we need to
> get unknown value of "EPYC-x86_64-cpu-xlevel" for 3.1 machine. These
> unknown values in the table are called "holes". To get values for these
> "holes" the script uses list of appropriate methods.)
>
> Notes:
> * Some init values from the devices can't be available like properties
>   from virtio-9p when configure has --disable-virtfs. This situations will
>   be seen in the table as "unavailable driver".
> * Default values can be obtained in an unobvious way, like x86 features.
>   If the script doesn't know how to get property default value to compare
>   one machine with another it fills "holes" with "unavailable method". Th=
is
>   is done because script uses whitelist model to get default values of
>   different types. It means that the method that can't be applied to a new
>   type that can crash this script. It is better to get an "unavailable
>   driver" when creating a new machine with new compatible properties than
>   to break this script. So it turns out a more stable and generic script.
> * If the default value can't be obtained because this property doesn't
>   exist or because this property can't have default value, appropriate
>   "hole" will be filled by "unknown property" or "no default value"
> * If the property is applied to the abstract class, the script collects
>   default values from all child classes (set of default values)
> * Raw table (--raw flag) should be used with json/csv parameters for
>   scripts and etc. Human-readable (default) format contains transformed
>   and simplified values and it doesn't contain lines with the same values
>   in columns
>
> Example:
> ./scripts/compare_mt.py --mt pc-q35-6.2 pc-q35-7.1
> =E2=95=92=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=A4=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A4=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=A4=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=95
> =E2=94=82      Driver      =E2=94=82         Property         =E2=94=82  =
build/qemu-system-x86_64  =E2=94=82  build/qemu-system-x86_64  =E2=94=82
> =E2=94=82                  =E2=94=82                          =E2=94=82  =
       pc-q35-6.2         =E2=94=82         pc-q35-7.1         =E2=94=82
> =E2=95=9E=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A1
> =E2=94=82     PIIX4_PM     =E2=94=82 x-not-migrate-acpi-index =E2=94=82  =
          True            =E2=94=82           False            =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82 arm-gicv3-common =E2=94=82     force-8-bit-prio     =E2=94=82  =
          True            =E2=94=82     unavailable driver     =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82     nvme-ns      =E2=94=82      eui64-default       =E2=94=82  =
          True            =E2=94=82           False            =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82    virtio-mem    =E2=94=82  unplugged-inaccessible  =E2=94=82  =
         False            =E2=94=82            auto            =E2=94=82
> =E2=95=98=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=A7=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A7=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=A7=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=9B
>
> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Co-developed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  scripts/compare_mt.py | 484 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 484 insertions(+)
>  create mode 100755 scripts/compare_mt.py
>
> diff --git a/scripts/compare_mt.py b/scripts/compare_mt.py
> new file mode 100755
> index 0000000000..685bd9a336
> --- /dev/null
> +++ b/scripts/compare_mt.py
> @@ -0,0 +1,484 @@
> +#!/usr/bin/env python3
> +#
> +# Script to compare machine type compatible properties (include/hw/board=
s.h).
> +# compat_props are applied to the driver during initialization to change
> +# default values, for instance, to maintain compatibility.
> +# This script constructs table with machines and values of their compat_=
props
> +# to compare and to find places for improvements or places with bugs. If
> +# during the comparison, some machine type doesn't have a property (it i=
s in
> +# the comparison table because another machine type has it), then the
> +# appropriate method will be used to obtain the default value of this dr=
iver
> +# property via qmp command (e.g. query-cpu-model-expansion for x86_64-cp=
u).
> +# These methods are defined below in qemu_property_methods.
> +#
> +# Copyright (c) Yandex Technologies LLC, 2023
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> +
> +import sys
> +from os import path
> +from argparse import ArgumentParser, RawTextHelpFormatter, Namespace
> +import pandas as pd
> +from contextlib import ExitStack
> +from typing import Optional, List, Dict, Generator, Tuple, Union, Any, S=
et
> +
> +try:
> +    qemu_dir =3D path.abspath(path.dirname(path.dirname(__file__)))
> +    sys.path.append(path.join(qemu_dir, 'python'))
> +    from qemu.machine import QEMUMachine
> +except ModuleNotFoundError as exc:
> +    print(f"Module '{exc.name}' not found.")
> +    print("Try export PYTHONPATH=3Dtop-qemu-dir/python or run from top-q=
emu-dir")
> +    sys.exit(1)
> +
> +
> +default_qemu_args =3D '-enable-kvm -machine none'
> +default_qemu_binary =3D 'build/qemu-system-x86_64'
> +
> +
> +# Methods for gettig the right values of drivers properties
> +#
> +# Use these methods as a 'whitelist' and add entries only if necessary. =
It's
> +# important to be stable and predictable in analysis and tests.
> +# Be careful:
> +# * Class must be inherited from 'QEMUObject' and used in new_driver()
> +# * Class has to implement get_prop method in order to get values
> +# * Specialization always wins (with the given classes for 'device' and
> +#   'x86_64-cpu', method of 'x86_64-cpu' will be used for '486-x86_64-cp=
u')
> +
> +class Driver():
> +    def __init__(self, vm: QEMUMachine, name: str, abstract: bool) -> No=
ne:
> +        self.vm =3D vm
> +        self.name =3D name
> +        self.abstract =3D abstract
> +        self.parent: Optional[Driver] =3D None
> +        self.property_getter: Optional[Driver] =3D None
> +
> +    def get_prop(self, driver: str, prop: str) -> str:
> +        if self.property_getter:
> +            return self.property_getter.get_prop(driver, prop)
> +        else:
> +            return 'Unavailable method'
> +
> +    def is_child_of(self, parent: 'Driver') -> bool:
> +        """Checks whether self is (recursive) child of @parent"""
> +        cur_parent =3D self.parent
> +        while cur_parent:
> +            if cur_parent is parent:
> +                return True
> +            cur_parent =3D cur_parent.parent
> +
> +        return False
> +
> +    def set_implementations(self, implementations: List['Driver']) -> No=
ne:
> +        self.implementations =3D implementations
> +
> +
> +class QEMUObject(Driver):
> +    def __init__(self, vm: QEMUMachine, name: str) -> None:
> +        super().__init__(vm, name, True)
> +
> +    def set_implementations(self, implementations: List[Driver]) -> None:
> +        self.implementations =3D implementations
> +
> +        # each implementation of the abstract driver has to use property=
 getter
> +        # of this abstract driver unless it has specialization. (e.g. ha=
ving
> +        # 'device' and 'x86_64-cpu', property getter of 'x86_64-cpu' wil=
l be
> +        # used for '486-x86_64-cpu')
> +        for impl in implementations:
> +            if not impl.property_getter or\
> +                    self.is_child_of(impl.property_getter):
> +                impl.property_getter =3D self
> +
> +
> +class QEMUDevice(QEMUObject):
> +    def __init__(self, vm: QEMUMachine) -> None:
> +        super().__init__(vm, 'device')
> +        self.cached: Dict[str, List[Dict[str, Any]]] =3D {}
> +
> +    def get_prop(self, driver: str, prop_name: str) -> str:
> +        if driver not in self.cached:
> +            self.cached[driver] =3D self.vm.cmd('device-list-properties',
> +                                              typename=3Ddriver)
> +        for prop in self.cached[driver]:
> +            if prop['name'] =3D=3D prop_name:
> +                return str(prop.get('default-value', 'No default value'))
> +
> +        return 'Unknown property'
> +
> +
> +class QEMUx86CPU(QEMUObject):
> +    def __init__(self, vm: QEMUMachine) -> None:
> +        super().__init__(vm, 'x86_64-cpu')
> +        self.cached: Dict[str, Dict[str, Any]] =3D {}
> +
> +    def get_prop(self, driver: str, prop_name: str) -> str:
> +        if not driver.endswith('-x86_64-cpu'):
> +            return 'Wrong x86_64-cpu name'
> +
> +        # crop last 11 chars '-x86_64-cpu'
> +        name =3D driver[:-11]
> +        if name not in self.cached:
> +            self.cached[name] =3D self.vm.cmd(
> +                'query-cpu-model-expansion', type=3D'full',
> +                model=3D{'name': name})['model']['props']
> +        return str(self.cached[name].get(prop_name, 'Unknown property'))
> +
> +
> +# Now it's stub, because all memory_backend types don't have default val=
ues
> +# but this behaviour can be changed
> +class QEMUMemoryBackend(QEMUObject):
> +    def __init__(self, vm: QEMUMachine) -> None:
> +        super().__init__(vm, 'memory-backend')
> +        self.cached: Dict[str, List[Dict[str, Any]]] =3D {}
> +
> +    def get_prop(self, driver: str, prop_name: str) -> str:
> +        if driver not in self.cached:
> +            self.cached[driver] =3D self.vm.cmd('qom-list-properties',
> +                                              typename=3Ddriver)
> +        for prop in self.cached[driver]:
> +            if prop['name'] =3D=3D prop_name:
> +                return str(prop.get('default-value', 'No default value'))
> +
> +        return 'Unknown property'
> +
> +
> +def new_driver(vm: QEMUMachine, name: str, is_abstr: bool) -> Driver:
> +    if name =3D=3D 'object':
> +        return QEMUObject(vm, 'object')
> +    elif name =3D=3D 'device':
> +        return QEMUDevice(vm)
> +    elif name =3D=3D 'x86_64-cpu':
> +        return QEMUx86CPU(vm)
> +    elif name =3D=3D 'memory-backend':
> +        return QEMUMemoryBackend(vm)
> +    else:
> +        return Driver(vm, name, is_abstr)
> +# End of methods definition
> +
> +
> +class VMPropertyGetter:
> +    """It implements the relationship between drivers and how to get the=
ir
> +    properties"""
> +    def __init__(self, vm: QEMUMachine) -> None:
> +        self.drivers: Dict[str, Driver] =3D {}
> +
> +        qom_all_types =3D vm.cmd('qom-list-types', abstract=3DTrue)
> +        self.drivers =3D {t['name']: new_driver(vm, t['name'],
> +                                              t.get('abstract', False))
> +                        for t in qom_all_types}
> +
> +        for t in qom_all_types:
> +            drv =3D self.drivers[t['name']]
> +            if 'parent' in t:
> +                drv.parent =3D self.drivers[t['parent']]
> +
> +        for drv in self.drivers.values():
> +            imps =3D vm.cmd('qom-list-types', implements=3Ddrv.name)
> +            # only implementations inherit property getter
> +            drv.set_implementations([self.drivers[imp['name']]
> +                                     for imp in imps])
> +
> +    def get_prop(self, driver: str, prop: str) -> str:
> +        # wrong driver name or disabled in config driver
> +        try:
> +            drv =3D self.drivers[driver]
> +        except KeyError:
> +            return 'Unavailable driver'
> +
> +        assert not drv.abstract
> +
> +        return drv.get_prop(driver, prop)
> +
> +    def get_implementations(self, driver: str) -> List[str]:
> +        return [impl.name for impl in self.drivers[driver].implementatio=
ns]
> +
> +
> +class Machine:
> +    """A short QEMU machine type description. It contains only processed
> +    compat_props (properties of abstract classes are applied to its
> +    implementations)
> +    """
> +    # raw_mt_dict - dict produced by `query-machines`
> +    def __init__(self, raw_mt_dict: Dict[str, Any],
> +                 qemu_drivers: VMPropertyGetter) -> None:
> +        self.name =3D raw_mt_dict['name']
> +        self.compat_props: Dict[str, Any] =3D {}
> +        # properties are applied sequentially and can rewrite values lik=
e in
> +        # QEMU. Also it has to resolve class relationships to apply appr=
opriate
> +        # values from abstract class to all implementations
> +        for prop in raw_mt_dict['compat-props']:
> +            driver =3D prop['driver']
> +            try:
> +                # implementation adds only itself, abstract class adds
> +                #  lementation (abstract classes are uninterestiong)
> +                impls =3D qemu_drivers.get_implementations(driver)
> +                for impl in impls:
> +                    if impl not in self.compat_props:
> +                        self.compat_props[impl] =3D {}
> +                    self.compat_props[impl][prop['property']] =3D prop['=
value']
> +            except KeyError:
> +                # QEMU doesn't know this driver thus it has to be saved
> +                if driver not in self.compat_props:
> +                    self.compat_props[driver] =3D {}
> +                self.compat_props[driver][prop['property']] =3D prop['va=
lue']
> +
> +
> +class Configuration():
> +    """Class contains all necessary components to generate table and is =
used
> +    to compare different binaries"""
> +    def __init__(self, vm: QEMUMachine,
> +                 req_mt: List[str], all_mt: bool) -> None:
> +        self._vm =3D vm
> +        self._binary =3D vm.binary
> +        self._qemu_args =3D args.qemu_args.split(' ')
> +
> +        self._qemu_drivers =3D VMPropertyGetter(vm)
> +        self.req_mt =3D get_req_mt(self._qemu_drivers, vm, req_mt, all_m=
t)
> +
> +    def get_implementations(self, driver_name: str) -> List[str]:
> +        return self._qemu_drivers.get_implementations(driver_name)
> +
> +    def get_table(self, req_props: List[Tuple[str, str]]) -> pd.DataFram=
e:
> +        table: List[pd.DataFrame] =3D []
> +        for mt in self.req_mt:
> +            name =3D f'{self._binary}\n{mt.name}'
> +            column =3D []
> +            for driver, prop in req_props:
> +                try:
> +                    # values from QEMU machine type definitions
> +                    column.append(mt.compat_props[driver][prop])
> +                except KeyError:
> +                    # values from QEMU type definitions
> +                    column.append(self._qemu_drivers.get_prop(driver, pr=
op))
> +            table.append(pd.DataFrame({name: column}))
> +
> +        return pd.concat(table, axis=3D1)
> +
> +
> +script_desc =3D """Script to compare machine types (their compat_props).
> +
> +Examples:
> +* save info about all machines:  ./scripts/compare_mt.py --all --format =
csv \
> +--raw > table.csv
> +* compare machines: ./scripts/compare_mt.py --mt pc-q35-2.12 pc-q35-3.0
> +* compare binaries and machines: ./scripts/compare_mt.py --mt pc-q35-6.2=
 \
> +pc-q35-7.0 --qemu-binary build/qemu-system-x86_64 build/qemu-exp
> +  =E2=95=92=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A4=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A4=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90\
> +=E2=95=A4=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A4=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A4=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=95
> +  =E2=94=82   Driver   =E2=94=82         Property         =E2=94=82  bui=
ld/qemu-system-x86_64  \
> +=E2=94=82  build/qemu-system-x86_64  =E2=94=82  build/qemu-exp  =E2=94=
=82  build/qemu-exp  =E2=94=82
> +  =E2=94=82            =E2=94=82                          =E2=94=82     =
    pc-q35-6.2         \
> +=E2=94=82         pc-q35-7.0         =E2=94=82    pc-q35-6.2    =E2=94=
=82    pc-q35-7.0    =E2=94=82
> +  =E2=95=9E=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90\
> +=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=AA=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=A1
> +  =E2=94=82  PIIX4_PM  =E2=94=82 x-not-migrate-acpi-index =E2=94=82     =
       True            \
> +=E2=94=82           False            =E2=94=82      False       =E2=94=
=82      False       =E2=94=82
> +  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80\
> +=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=A4
> +  =E2=94=82 virtio-mem =E2=94=82  unplugged-inaccessible  =E2=94=82     =
      False            \
> +=E2=94=82            auto            =E2=94=82      False       =E2=94=
=82       auto       =E2=94=82
> +  =E2=95=98=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A7=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A7=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90\
> +=E2=95=A7=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A7=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=A7=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=9B
> +
> +If a property from QEMU machine defintion applies to an abstract class (=
e.g. \
> +x86_64-cpu) this script will compare all implementations of this class.
> +
> +"Unavailable method" - means that this script doesn't know how to get \
> +default values of the driver. To add method use the construction describ=
ed \
> +at the top of the script.
> +"Unavailable driver" - means that this script doesn't know this driver. \
> +For instance, this can happen if you configure QEMU without this device =
or \
> +if machine type definition has error.
> +"No default value" - means that the appropriate method can't get the def=
ault \
> +value and most likely that this property doesn't have it.
> +"Unknown property" - means that the appropriate method can't find proper=
ty \
> +with this name."""
> +
> +
> +def parse_args() -> Namespace:
> +    parser =3D ArgumentParser(formatter_class=3DRawTextHelpFormatter,
> +                            description=3Dscript_desc)
> +    parser.add_argument('--format', choices=3D['human-readable', 'json',=
 'csv'],
> +                        default=3D'human-readable',
> +                        help=3D'returns table in json format')
> +    parser.add_argument('--raw', action=3D'store_true',
> +                        help=3D'prints ALL defined properties without va=
lue '
> +                             'transformation. By default, only rows '
> +                             'with different values will be printed and '
> +                             'values will be transformed(e.g. "on" -> Tr=
ue)')
> +    parser.add_argument('--qemu-args', default=3Ddefault_qemu_args,
> +                        help=3D'command line to start qemu. '
> +                             f'Default: "{default_qemu_args}"')
> +    parser.add_argument('--qemu-binary', nargs=3D"*", type=3Dstr,
> +                        default=3D[default_qemu_binary],
> +                        help=3D'list of qemu binaries that will be compa=
red. '
> +                             f'Deafult: {default_qemu_binary}')
> +
> +    mt_args_group =3D parser.add_mutually_exclusive_group()
> +    mt_args_group.add_argument('--all', action=3D'store_true',
> +                               help=3D'prints all available machine type=
s (list '
> +                                    'of machine types will be ignored)')
> +    mt_args_group.add_argument('--mt', nargs=3D"*", type=3Dstr,
> +                               help=3D'list of Machine Types '
> +                                    'that will be compared')
> +
> +    return parser.parse_args()
> +
> +
> +def mt_comp(mt: Machine) -> Tuple[str, int, int, int]:
> +    """Function to compare and sort machine by names.
> +    It returns socket_name, major version, minor version, revision"""
> +    # none, microvm, x-remote and etc.
> +    if '-' not in mt.name or '.' not in mt.name:
> +        return mt.name, 0, 0, 0
> +
> +    socket, ver =3D mt.name.rsplit('-', 1)
> +    ver_list =3D list(map(int, ver.split('.', 2)))
> +    ver_list +=3D [0] * (3 - len(ver_list))
> +    return socket, ver_list[0], ver_list[1], ver_list[2]
> +
> +
> +def get_mt_definitions(qemu_drivers: VMPropertyGetter,
> +                       vm: QEMUMachine) -> List[Machine]:
> +    """Constructs list of machine definitions (primarily compat_props) v=
ia
> +    info from QEMU"""
> +    raw_mt_defs =3D vm.cmd('query-machines', compat_props=3DTrue)
> +    mt_defs =3D []
> +    for raw_mt in raw_mt_defs:
> +        mt_defs.append(Machine(raw_mt, qemu_drivers))
> +
> +    mt_defs.sort(key=3Dmt_comp)
> +    return mt_defs
> +
> +
> +def get_req_mt(qemu_drivers: VMPropertyGetter, vm: QEMUMachine,
> +               req_mt: Optional[List[str]], all_mt: bool) -> List[Machin=
e]:
> +    """Returns list of requested by user machines"""
> +    mt_defs =3D get_mt_definitions(qemu_drivers, vm)
> +    if all_mt:
> +        return mt_defs
> +
> +    if req_mt is None:
> +        print('Enter machine types for comparision')
> +        exit(0)
> +
> +    matched_mt =3D []
> +    for mt in mt_defs:
> +        if mt.name in req_mt:
> +            matched_mt.append(mt)
> +
> +    return matched_mt
> +
> +
> +def get_affected_props(configs: List[Configuration]) -> Generator[Tuple[=
str,
> +                                                                        =
str],
> +                                                                  None, =
None]:
> +    """Helps to go through all affected in machine definitions drivers
> +    and properties"""
> +    driver_props: Dict[str, Set[Any]] =3D {}
> +    for config in configs:
> +        for mt in config.req_mt:
> +            compat_props =3D mt.compat_props
> +            for driver, prop in compat_props.items():
> +                if driver not in driver_props:
> +                    driver_props[driver] =3D set()
> +                driver_props[driver].update(prop.keys())
> +
> +    for driver, props in sorted(driver_props.items()):
> +        for prop in sorted(props):
> +            yield driver, prop
> +
> +
> +def transform_value(value: str) -> Union[str, bool]:
> +    true_list =3D ['true', 'on']
> +    false_list =3D ['false', 'off']
> +
> +    out =3D value.lower()
> +
> +    if out in true_list:
> +        return True
> +
> +    if out in false_list:
> +        return False
> +
> +    return value
> +
> +
> +def simplify_table(table: pd.DataFrame) -> pd.DataFrame:
> +    """transforms values to make it easier to compare it and drops rows
> +    with the same values for all columns"""
> +
> +    table =3D table.map(transform_value)
> +
> +    return table[~table.iloc[:, 3:].eq(table.iloc[:, 2], axis=3D0).all(a=
xis=3D1)]
> +
> +
> +# constructs table in the format:
> +#
> +# Driver  | Property  | binary1  | binary1  | ...
> +#         |           | machine1 | machine2 | ...
> +# ------------------------------------------------------ ...
> +# driver1 | property1 |  value1  |  value2  | ...
> +# driver1 | property2 |  value3  |  value4  | ...
> +# driver2 | property3 |  value5  |  value6  | ...
> +#   ...   |    ...    |   ...    |   ...    | ...
> +#
> +def fill_prop_table(configs: List[Configuration],
> +                    is_raw: bool) -> pd.DataFrame:
> +    req_props =3D list(get_affected_props(configs))
> +    if not req_props:
> +        print('No drivers to compare. Check machine names')
> +        exit(0)
> +
> +    driver_col, prop_col =3D tuple(zip(*req_props))
> +    table =3D [pd.DataFrame({'Driver': driver_col}),
> +             pd.DataFrame({'Property': prop_col})]
> +
> +    table.extend([config.get_table(req_props) for config in configs])
> +
> +    df_table =3D pd.concat(table, axis=3D1)
> +
> +    if is_raw:
> +        return df_table
> +
> +    return simplify_table(df_table)
> +
> +
> +def print_table(table: pd.DataFrame, table_format: str) -> None:
> +    if table_format =3D=3D 'json':
> +        print(comp_table.to_json())
> +    elif table_format =3D=3D 'csv':
> +        print(comp_table.to_csv())
> +    else:
> +        print(comp_table.to_markdown(index=3DFalse, stralign=3D'center',
> +                                     colalign=3D('center',), headers=3D'=
keys',
> +                                     tablefmt=3D'fancy_grid',
> +                                     disable_numparse=3DTrue))
> +
> +
> +if __name__ =3D=3D '__main__':
> +    args =3D parse_args()
> +    with ExitStack() as stack:
> +        vms =3D [stack.enter_context(QEMUMachine(binary=3Dbinary, qmp_ti=
mer=3D15,
> +               args=3Dargs.qemu_args.split(' '))) for binary in args.qem=
u_binary]
> +
> +        configurations =3D []
> +        for vm in vms:
> +            vm.launch()
> +            configurations.append(Configuration(vm, args.mt, args.all))
> +
> +        comp_table =3D fill_prop_table(configurations, args.raw)
> +        if not comp_table.empty:
> +            print_table(comp_table, args.format)


