Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828077F5E5
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWbg6-0003wY-6X; Thu, 17 Aug 2023 08:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWbg3-0003ug-SY
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWbg1-0003GY-8a
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692273632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhenWrlq25iwktp1alF8gD0gYkCNbgENGehPS71u3ik=;
 b=BBJxF2ueYVS7mM0n9t3uqo8cV97jYd34i8Syz9eQKLlpF+Tt75zeVn7s2WPvfEbCaTyBV5
 jm4o1uOt2MQjjZtM2WrSJq0MYwoxgFi+K7BcAHnSBi5jsdAiVIYS9/winLXog6kSJkUgcm
 kSePzOzNwd8zZD8iZ0SFTKHRWz87g10=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-pjaakixZNsyj0Go8eh94Lg-1; Thu, 17 Aug 2023 08:00:30 -0400
X-MC-Unique: pjaakixZNsyj0Go8eh94Lg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe216798e9so50736065e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 05:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692273629; x=1692878429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhenWrlq25iwktp1alF8gD0gYkCNbgENGehPS71u3ik=;
 b=XBDkby3u5CiCn398vKjXSSMI7OUxmU6eWnWvHtea4iUdL2P+4oiTNGE4ybUi4JhUuu
 AS78xLLmZt756KmfnCJ1XbZ0Y82yVqdoSBRmrh5OBBB029Ki71ZjW04rVs3o+zGbbrdz
 EFIcAi5O3loYrbThtMJo6LZC5slDEd10Uv7mMpKKignYF4G/E9KJkdYhdgkZgnhIQCQx
 TDPJ7bBbPB3B1UxGVFJ83AX4JOxhxrIDnqbiWTxlJkohd+32V8j7tx60GvatOdtJae67
 RFHUyJWn+0n7bks46fEjtoNN3eVLpOb675ey4tP+rIx4oRfh2/Bm6vaRGeR2JfmxW/e7
 3DdQ==
X-Gm-Message-State: AOJu0YzZFpP1TqwgbOIslZlAv3Hx5b2G6iIu9PQqsXpcb2wF4+40/ARl
 bZ/tS4lIBLxQ5ACeFat9JkQwz91s7qm7Nqt62DnrLCNbpuY2b3QqaUnOD2TwgAQam2III5xNsw5
 75A+9XRw3ESEmv/ad2YjErBdlyQ==
X-Received: by 2002:a7b:ce8d:0:b0:3fc:616:b0db with SMTP id
 q13-20020a7bce8d000000b003fc0616b0dbmr3797964wmj.9.1692273629348; 
 Thu, 17 Aug 2023 05:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBirgDG1jniL1GfjVgcNM86GgDKgIoMJ6kPxBzRJPqAbiLsDRRzY41MuNxaosXac+pnWNejw==
X-Received: by 2002:a7b:ce8d:0:b0:3fc:616:b0db with SMTP id
 q13-20020a7bce8d000000b003fc0616b0dbmr3797945wmj.9.1692273629037; 
 Thu, 17 Aug 2023 05:00:29 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-113-156.web.vodafone.de.
 [109.42.113.156]) by smtp.gmail.com with ESMTPSA id
 q25-20020a7bce99000000b003fe17e04269sm2705945wmj.40.2023.08.17.05.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 05:00:28 -0700 (PDT)
Message-ID: <2bb2f8ac-43b4-9505-c163-d29964bf6a30@redhat.com>
Date: Thu, 17 Aug 2023 14:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] chardev/char-pty: Avoid losing bytes when the other side
 just (re-)connected
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
References: <20230816210743.1319018-1-thuth@redhat.com>
 <ZN33W+LhAn2FrFDT@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZN33W+LhAn2FrFDT@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17/08/2023 12.32, Daniel P. Berrangé wrote:
> On Wed, Aug 16, 2023 at 11:07:43PM +0200, Thomas Huth wrote:
>> When starting a guest via libvirt with "virsh start --console ...",
>> the first second of the console output is missing. This is especially
>> annoying on s390x that only has a text console by default and no graphical
>> output - if the bios fails to boot here, the information about what went
>> wrong is completely lost.
>>
>> One part of the problem (there is also some things to be done on the
>> libvirt side) is that QEMU only checks with a 1 second timer whether
>> the other side of the pty is already connected, so the first second of
>> the console output is always lost.
>>
>> This likely used to work better in the past, since the code once checked
>> for a re-connection during write, but this has been removed in commit
>> f8278c7d74 ("char-pty: remove the check for connection on write") to avoid
>> some locking.
>>
>> To ease the situation here at least a little bit, let's check with g_poll()
>> whether we could send out the data anyway, even if the connection has not
>> been marked as "connected" yet. The file descriptor is marked as non-blocking
>> anyway since commit fac6688a18 ("Do not hang on full PTY"), so this should
>> not cause any trouble if the other side is not ready for receiving yet.
>>
>> With this patch applied, I can now successfully see the bios output of
>> a s390x guest when running it with "virsh start --console" (with a patched
>> version of virsh that fixes the remaining issues there, too).
>>
>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   chardev/char-pty.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>> index 4e5deac18a..fad12dfef3 100644
>> --- a/chardev/char-pty.c
>> +++ b/chardev/char-pty.c
>> @@ -106,11 +106,27 @@ static void pty_chr_update_read_handler(Chardev *chr)
>>   static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
>>   {
>>       PtyChardev *s = PTY_CHARDEV(chr);
>> +    GPollFD pfd;
>> +    int rc;
>>   
>> -    if (!s->connected) {
>> -        return len;
>> +    if (s->connected) {
>> +        return io_channel_send(s->ioc, buf, len);
>>       }
>> -    return io_channel_send(s->ioc, buf, len);
>> +
>> +    /*
>> +     * The other side might already be re-connected, but the timer might
>> +     * not have fired yet. So let's check here whether we can write again:
>> +     */
>> +    pfd.fd = QIO_CHANNEL_FILE(s->ioc)->fd;
>> +    pfd.events = G_IO_OUT;
>> +    pfd.revents = 0;
>> +    rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>> +    g_assert(rc >= 0);
>> +    if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
> 
> Should (can?) we call
> 
>     pty_chr_state(chr, 1);
> 
> here ?

As far as I understood commit f8278c7d74c6 and f7ea2038bea04628, this is not 
possible anymore since the lock has been removed.

>> +        io_channel_send(s->ioc, buf, len);
> 
> As it feels a little dirty to be sending data before setting the
> 'connected == 1' and thus issuing the 'CHR_EVENT_OPENED' event

I didn't find a really better solution so far. We could maybe introduce a 
buffer in the char-pty code and store the last second of guest output, but 
IMHO that's way more complex and thus somewhat ugly, too?

  Thomas



