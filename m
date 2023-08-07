Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141D773133
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 23:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT7kj-0007eW-Kx; Mon, 07 Aug 2023 17:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <werner@carne.de>) id 1qT7kb-0007cE-K8
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 17:26:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <werner@carne.de>) id 1qT7kZ-0008Jo-6z
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 17:26:53 -0400
Received: from core2.homenet.local ([84.169.127.92]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhUHt-1ppxNE30dv-00eZWQ; Mon, 07 Aug 2023 23:26:47 +0200
Received: from [192.168.1.191] (unknown [192.168.1.191])
 by core2.homenet.local (Postfix) with ESMTP id 25C5C6438CC2;
 Mon,  7 Aug 2023 23:26:47 +0200 (CEST)
Content-Type: multipart/alternative;
 boundary="------------lCirNIAQkdGlohLec0C94mj6"
Message-ID: <c9343da4-e453-ac59-ff86-be11008033aa@carne.de>
Date: Mon, 7 Aug 2023 23:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial COM: windows serial COM PollingFunc don't sleep
Content-Language: de-DE
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230807201443.2668-1-werner@carne.de>
 <CAJ+F1CJk_7reShjGcUBGszX2LFpmVUapBibtQnYBpxmWDp+mgw@mail.gmail.com>
From: Werner de Carne <werner@carne.de>
In-Reply-To: <CAJ+F1CJk_7reShjGcUBGszX2LFpmVUapBibtQnYBpxmWDp+mgw@mail.gmail.com>
X-Provags-ID: V03:K1:6S2nnxqhdK/z65ZvkBeVn1QqZvgYkVsbFmtFHTjiBn938Apaaf9
 e/sNA6gq+BctyuCZpO0m41hQfKjm6m1+LDxMhQreChX85X7pV4hXabOrox+O9g+X0XAdLBu
 SPAzjaktjCDHckz3LESEt6cdM3ZMg9+ymdelvxCDBAWHth2q2xWMS52fYYGZB6CEberI9Tx
 TWLlBX/IzfbAeEgx0aG4Q==
UI-OutboundReport: notjunk:1;M01:P0:ClUGHNzliWQ=;RZGaQGzw5elx8W9qdJYU9yIVCJ5
 iaG4o5WV9wUEATACKrzDVS9yVC+yoYzLFm0aq1dBVQfz9Px0+MgR6rT767D+DxcBDS/TaweKE
 eg9QhK9pu2Qp8mFnp1HvA5xGjKwv15zpEtI5dbNkI9DFO6Uz0aONhRVu00s2ZnvZFG7Nwy7s5
 olTGoTeGWU/ms1RYhazMbMWV15I3YfMpdxZ0T8UeWlwMxDRNxNE7KcMgRhcV+uRuvhhdlRtvW
 r9Mnti+fSXdJ/PMqOpJuOQexUlXyMIrIEu1EosADQLSm1TidieG1wewRxS0jwJkZHcheGQ9dN
 w91kFJL0/jVjUWw8GycVgvs3szO58NW3BXrJClZIboR70fardkusmFPN3bK5xg83pL5bD89a+
 /wEPcTSFZFRAN2XNDKCrwLrRFbUG/DjbGP4NdyJCO7S63hrSsJBUNFs437eReU0e2AiDlKNf0
 CAviFzBODK0jl7/9+HH0NmD41o8IrF+6QW9RLsQSSJoLokXkAhBrOwaXTvHTyNHHTs3/wk40C
 uGrLXREPpMdTjxiOH7Md1rXVuUGbM9Pud40L6Ch2t2+UC+Cg7ToiqlVfgWq4WX9vBvkh3iETc
 kBZuuM3KQVSNgibgSeZc7QEa1Cp7oYKyMMQJ7kx/JZYXqmu6Jn5tOXXcODtg+m/l99NPJ6UXe
 7n5oqDwhEOXhy7f/qTjRkjY3BodvGIb1FwNbLfzq0QCvzAHY32ESwhWCEF9W5SFAvmKntyBLq
 ym+T09SNmeHrSTMG7nGxCS6EzIgzw3y9LdDXdWtQzkekIZri5w265gWlcAb51dGhUYQ4RjGQ6
 VBKBOrk3F+wOSbzmBK5CYoTXVd0fXAHMi3PIkKL8MQWk2j/mOHnSXsj3oNnQ/NvL4h7ZOT2Fi
 sG8gVnTmOBxJNlw==
Received-SPF: pass client-ip=217.72.192.75; envelope-from=werner@carne.de;
 helo=mout.kundenserver.de
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

This is a multi-part message in MIME format.
--------------lCirNIAQkdGlohLec0C94mj6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc-André,

when processing 2 or more characters, the guest machine mps2-an386 (uart 
has a 1 character fifo) will only process one character. Without the 
loop break, the guest gets no computing time and no further character 
can be processed. The guest gets no more computing time and so 
everything freezes. It is also sufficient to connect the uart0 from the 
guest to the Windows host with -serial COMx, but do not activate the 
uart0 in the guest. The receipt of a single character at the Windows 
host also results in the deadlock.

greetings

Am 07.08.2023 um 22:59 schrieb Marc-André Lureau:
> Hi Werner
>
> On Tue, Aug 8, 2023 at 12:46 AM Werner de Carne<werner@carne.de>  wrote:
>> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1802
>> Signed-off-by: Werner de Carne<werner@carne.de>
> This changes the polling callback to return 0 when I/O can't be
> processed.  in util/main-loop.c, it results in an early break of
> os_host_main_loop_wait().
>
> How does that help?
>
> thanks
>
>> ---
>>   chardev/char-win.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/chardev/char-win.c b/chardev/char-win.c
>> index d4fb44c4dc..92a7016105 100644
>> --- a/chardev/char-win.c
>> +++ b/chardev/char-win.c
>> @@ -28,7 +28,7 @@
>>   #include "qapi/error.h"
>>   #include "chardev/char-win.h"
>>
>> -static void win_chr_read(Chardev *chr, DWORD len)
>> +static int win_chr_read(Chardev *chr, DWORD len)
>>   {
>>       WinChardev *s = WIN_CHARDEV(chr);
>>       int max_size = qemu_chr_be_can_write(chr);
>> @@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
>>           len = max_size;
>>       }
>>       if (len == 0) {
>> -        return;
>> +        return 0;
>>       }
>>
>>       ZeroMemory(&s->orecv, sizeof(s->orecv));
>> @@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
>>       if (size > 0) {
>>           qemu_chr_be_write(chr, buf, size);
>>       }
>> +
>> +    return size > 0 ? 1 : 0;
>>   }
>>
>>   static int win_chr_serial_poll(void *opaque)
>> @@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)
>>
>>       ClearCommError(s->file, &comerr, &status);
>>       if (status.cbInQue > 0) {
>> -        win_chr_read(chr, status.cbInQue);
>> -        return 1;
>> +        if (win_chr_read(chr, status.cbInQue)) {
>> +                       return 1;
>> +               }
>>       }
>>       return 0;
>>   }
>> @@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)
>>
>>       PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
>>       if (size > 0) {
>> -        win_chr_read(chr, size);
>> -        return 1;
>> +       if (win_chr_read(chr, size)) {
>> +                       return 1;
>> +               }
>>       }
>>       return 0;
>>   }
>> --
>> 2.28.0.windows.1
>>
>>
>

--------------lCirNIAQkdGlohLec0C94mj6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi Marc-André,<br>
      <br>
      when processing 2 or more characters, the guest machine mps2-an386
      (uart has a 1 character fifo) will only process one character.
      Without the loop break, the guest gets no computing time and no
      further character can be processed. The guest gets no more
      computing time and so everything freezes. It is also sufficient to
      connect the uart0 from the guest to the Windows host with -serial
      COMx, but do not activate the uart0 in the guest. The receipt of a
      single character at the Windows host also results in the deadlock.</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix"><span class="HwtZe" lang="en"><span
          class="jCAhz ChMk0b"><span class="ryNqvb">greetings</span></span></span></div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">Am 07.08.2023 um 22:59 schrieb
      Marc-André Lureau:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJ+F1CJk_7reShjGcUBGszX2LFpmVUapBibtQnYBpxmWDp+mgw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">Hi Werner

On Tue, Aug 8, 2023 at 12:46 AM Werner de Carne <a class="moz-txt-link-rfc2396E" href="mailto:werner@carne.de">&lt;werner@carne.de&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Resolves: <a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/issues/1802">https://gitlab.com/qemu-project/qemu/-/issues/1802</a>
Signed-off-by: Werner de Carne <a class="moz-txt-link-rfc2396E" href="mailto:werner@carne.de">&lt;werner@carne.de&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This changes the polling callback to return 0 when I/O can't be
processed.  in util/main-loop.c, it results in an early break of
os_host_main_loop_wait().

How does that help?

thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">---
 chardev/char-win.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/chardev/char-win.c b/chardev/char-win.c
index d4fb44c4dc..92a7016105 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "chardev/char-win.h"

-static void win_chr_read(Chardev *chr, DWORD len)
+static int win_chr_read(Chardev *chr, DWORD len)
 {
     WinChardev *s = WIN_CHARDEV(chr);
     int max_size = qemu_chr_be_can_write(chr);
@@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
         len = max_size;
     }
     if (len == 0) {
-        return;
+        return 0;
     }

     ZeroMemory(&amp;s-&gt;orecv, sizeof(s-&gt;orecv));
@@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
     if (size &gt; 0) {
         qemu_chr_be_write(chr, buf, size);
     }
+
+    return size &gt; 0 ? 1 : 0;
 }

 static int win_chr_serial_poll(void *opaque)
@@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)

     ClearCommError(s-&gt;file, &amp;comerr, &amp;status);
     if (status.cbInQue &gt; 0) {
-        win_chr_read(chr, status.cbInQue);
-        return 1;
+        if (win_chr_read(chr, status.cbInQue)) {
+                       return 1;
+               }
     }
     return 0;
 }
@@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)

     PeekNamedPipe(s-&gt;file, NULL, 0, NULL, &amp;size, NULL);
     if (size &gt; 0) {
-        win_chr_read(chr, size);
-        return 1;
+       if (win_chr_read(chr, size)) {
+                       return 1;
+               }
     }
     return 0;
 }
--
2.28.0.windows.1


</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------lCirNIAQkdGlohLec0C94mj6--

