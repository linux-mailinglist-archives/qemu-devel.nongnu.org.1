Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 017647ADB97
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkndA-0005DI-4e; Mon, 25 Sep 2023 11:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qknd6-0005C9-Jt
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qknd1-0001Oj-Sh
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695656166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvmPGYImo/JjCc16EtHVIVasFe93+qns9OGqvrjgxAw=;
 b=CO+ttoty83Sx9npJz6kG9Pms6kWAh/nkb7LsnooH6tyi+S1p13EMBASPgUsCCqyrrRpeI8
 CcLPCizENsOHfBW3aRvsWqTUz34L4O30DpCcu0E3HRBZ8W8vUV1/Khe1wzDRct5z6GVud1
 HirJjeIc04cYgPqbQDMLQVa6ePUIVM8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-9siCX3uXNC-CsMgBt81b7w-1; Mon, 25 Sep 2023 11:36:03 -0400
X-MC-Unique: 9siCX3uXNC-CsMgBt81b7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 270D01C294BA;
 Mon, 25 Sep 2023 15:36:03 +0000 (UTC)
Received: from [10.39.194.7] (unknown [10.39.194.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6097E40C2070;
 Mon, 25 Sep 2023 15:36:02 +0000 (UTC)
Message-ID: <4c36a1eb-9a76-2231-4ead-d8daab657d84@redhat.com>
Date: Mon, 25 Sep 2023 17:36:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230913144959.41891-1-lersek@redhat.com>
 <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 9/15/23 13:50, Marc-André Lureau wrote:
> Hi Laszlo
> 
> On Wed, Sep 13, 2023 at 6:50 PM Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> Fix a recent regression (crash) in the multihead check; clean up the
>> code some more.
>>
>> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graphics)
>> Cc: Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
>>
>> Thanks,
>> Laszlo
>>
>> Laszlo Ersek (4):
>>   ui/console: make qemu_console_is_multihead() static
>>   ui/console: only walk QemuGraphicConsoles in
>>     qemu_console_is_multihead()
>>   ui/console: eliminate QOM properties from qemu_console_is_multihead()
>>   ui/console: sanitize search in qemu_graphic_console_is_multihead()
> 
> Series:
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Thanks.

Has this been queued by someone? Both Gerd and Marc-André are "odd
fixers", so I'm not sure who should be sending a PR with these patches
(and I don't see a pending PULL at
<https://lists.gnu.org/archive/html/qemu-devel/2023-09/threads.html>
with these patch subjects included).

Thanks.
Laszlo


