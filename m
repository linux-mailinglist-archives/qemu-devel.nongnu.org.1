Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA2C82EA18
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:34:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdxI-00087M-K3; Tue, 16 Jan 2024 02:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPdx9-0007x5-21
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPdx6-00043X-8o
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705390419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sie3WZ1dFfdAruYdXi28MzXSkiJXW1RwC0G+d7//jys=;
 b=OtVP3xMXpN9K6yBQD5kOEmPz2hkMvkLS6BC0BGIhczMiVXQgtGuQPOvHo9zICi7WWKEiXe
 54tFOSvUlVLgABgZ19/6FHxxNXyf8bHoxTjoKhuldLrhX8qpqUPPZIM/zCI8GP8MN/oqmU
 NCjcIdfXUP03TE8G555LYAGDvZ5vmS0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-jITDvw5QPByn6ENL5mtn9A-1; Tue, 16 Jan 2024 02:33:36 -0500
X-MC-Unique: jITDvw5QPByn6ENL5mtn9A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68CC8848B71;
 Tue, 16 Jan 2024 07:33:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 412F8492BC6;
 Tue, 16 Jan 2024 07:33:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 40AFE21E66C8; Tue, 16 Jan 2024 08:33:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bohdan Kostiv <bogdan.kostiv@gmail.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH] Fixed '-serial none' usage breaks following '-serial
 ...' usage
In-Reply-To: <CAFEAcA_5ip7q0Wp=jJkV7sJg=w=e08JCRqPmQuOObNe8AMZLDA@mail.gmail.com>
 (Peter Maydell's message of "Mon, 15 Jan 2024 16:14:30 +0000")
References: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
 <CAFEAcA_5ip7q0Wp=jJkV7sJg=w=e08JCRqPmQuOObNe8AMZLDA@mail.gmail.com>
Date: Tue, 16 Jan 2024 08:33:34 +0100
Message-ID: <8734ux91gx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> (I've cc'd a few people who might have opinions on possible
> command-line compatibility breakage.)
>
> On Wed, 10 Jan 2024 at 14:38, Bohdan Kostiv <bogdan.kostiv@gmail.com> wrote:
>>
>> Hello,
>>
>> I have faced an issue in using serial ports when I need to skip a couple of ports in the CLI.
>>
>> For example the ARM machine netduinoplus2 supports up to 7 UARTS.
>> Following case works (the first UART is used to send data in the firmware):
>> qemu-system-arm -machine netduinoplus2 -nographic -serial mon:stdio -kernel path-to-fw/firmware.elf
>> But this one doesn't  (the third UART is used to send data in the firmware):
>> qemu-system-arm -machine netduinoplus2 -nographic -serial none -serial none -serial mon:stdio -kernel path-to-fw/firmware.elf
>
> Putting the patch inline for more convenient discussion:
>
>> Subject: [PATCH] Fixed '-serial none' usage breaks following '-serial ...' usage
>>
>> Signed-off-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
>> ---
>>  system/vl.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index 2bcd9efb9a..b8744475cd 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -1442,8 +1442,11 @@ static int serial_parse(const char *devname)
>>      int index = num_serial_hds;
>>      char label[32];
>>
>> -    if (strcmp(devname, "none") == 0)
>> +    if (strcmp(devname, "none") == 0) {
>> +        num_serial_hds++;
>>          return 0;
>> +    }
>> +
>>      snprintf(label, sizeof(label), "serial%d", index);
>>      serial_hds = g_renew(Chardev *, serial_hds, index + 1);
>>
>> --
>> 2.39.3 (Apple Git-145)
>
> I agree that it's the right thing to do -- '-serial none
> -serial foo' ought to set serial_hds(0) as 'none' and
> serial_hds(1) as 'foo'.

I was about to ask whether this is a regression, but then ...

> My only concern here is that this is a very very
> longstanding bug -- as far as I can see it was
> introduced in commit 998bbd74b9d81 in 2009.

... saw you already showed it is.

>                                             So I am
> a little worried that maybe some existing command lines
> accidentally rely on the current behaviour.
>
> I think the current behaviour is:
>
>  * "-serial none -serial something" is the same as
>    "-serial something"
>  * "-serial none" on its own disables the default serial
>    device (the docs say it will "disable all serial ports"
>    but I don't think that is correct...)

Goes back all the way to the commit that introduced "none": c03b0f0fd86
(allow disabling of serial or parallel devices (Stefan Weil)), v0.9.0.

> which amounts to "the only effectively useful use of
> '-serial none' is to disable the default serial device"

Yes.

> and if we apply this patch:
>  * "-serial none -serial something" has the sensible behaviour
>    of "first serial port not connected/present, second serial
>    port exists" (which of those you get depends on the machine
>    model)

Is this the behavior before commit 998bbd74b9d?

>  * "-serial none" on its own has no behaviour change
>
> So I think the only affected users would be anybody who
> accidentally had an extra "-serial none" in their command
> line that was previously being overridden by a later
> "-serial" option. That doesn't seem very likely to me,
> so I think I'd be in favour of making this change and
> having something in the release notes about it.
>
> Does anybody on the CC list have a different opinion /
> think I've mis-analysed what the current code is doing ?

I'm leaning towards agreeing with you.  A bit more heavily if the change
restores original behavior.

Your analysis should be worked into the commit message, though.


