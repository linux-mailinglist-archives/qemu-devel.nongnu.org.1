Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F28831951
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:42:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRNi-0000f8-NH; Thu, 18 Jan 2024 07:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQRNc-0000eJ-6g
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:20:20 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQRNZ-0003OZ-SP
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:20:19 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-559cef15db5so1284639a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705580416; x=1706185216; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBFgAn6mLSL6Er50PQl4EyEf/G+pXg6i15jyXgl3RBA=;
 b=wdflkbO67S0hJp8S1PSdvexopDRqkeocNCXdJOrO43+2E+45FPKpa15wgcteRAnnBl
 NoIEWT9bYp2OdBcO5UhVhvnVHrmZck2E0cOeAA5ISnYaxE/fGMzyQE1uUOvDDOmXQHje
 fMj8TKh1g8dIXq/PPzjlIH+VVkQT9BfhVvZkLuf9vHywkgHKMc31c9qXkOhfCuuQy7Ez
 N3KoDpANy83j4nCHnAYHZtCs7UIJ9BSW7E+zx8Y/apCQab3yFmOXUIvF5XDc0m+9DjM0
 Xa1apJLknyStYq2sFdupzrlhstmnOV4vqBObDnoLxG5LoBhQFM1GcWX72ZHHOVrTbD8w
 Ww8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580416; x=1706185216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBFgAn6mLSL6Er50PQl4EyEf/G+pXg6i15jyXgl3RBA=;
 b=bpkgwoTmmD5xKVTiMj0RiOpJE8dKG5jMVZy6H3S7DMGzCRYILBTcBzI6ZBTmoRuV+8
 C2ZnWmn53zvoVzJxyMLMQXBFeBlF15ZaxeALEXIU4Jog3QokswP3kFSu/QMD0QHcffuQ
 hJk35wFs/S4UfDBmTnWE279YFWxt87lf6bP9difbgOlpwMzYUa3JTQv22oxFbLSfsLXP
 YPLCuY/r0C6uz6/Ncnk7Uy0MDghDgblrhv00SOR9pHCqYFAWAiWkG3qDH8+ugyRTVh69
 PjDj4Zil60rr1cdVOc5AsqGIW60BqcvPla0rhnVpIsP9W24uEsUjnExZeudNUixPH/D8
 9W6Q==
X-Gm-Message-State: AOJu0Yy97t6FU4NRIFKv+l22JJh5tG5fRfZznDRO7pdlBtMja58UPdKP
 3T569D4lk9P0LE4lenZepYh5Ib9BpucnyLc5+ukhmfLp9qZUZ8e/3yKUWK5VaYai+e6PTUuGT00
 falspfTgNEopLJPzXLAlVlZV77yN6/tKFkanaJA==
X-Google-Smtp-Source: AGHT+IGHWRBtQa2vZz6DqKK5G/ojC6R0/asQdpmk3mGn9h360xNEJSnQtTvSFwvANoYfFWNJH+woyjMjsXk41uQxXog=
X-Received: by 2002:a17:906:5a:b0:a2c:cdef:b03c with SMTP id
 26-20020a170906005a00b00a2ccdefb03cmr2475748ejg.30.1705580415861; Thu, 18 Jan
 2024 04:20:15 -0800 (PST)
MIME-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
 <CAFEAcA-2U=8nQH85tQQOPebDbpWuxsQ9_XdSSbiaR1Z8oNZ3PQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-2U=8nQH85tQQOPebDbpWuxsQ9_XdSSbiaR1Z8oNZ3PQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2024 12:20:04 +0000
Message-ID: <CAFEAcA_PpvrrsZa53QoaPq3tyi6yUh1y-1p5Kw0Fx_dQN+RNiQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/10] Implementation of NPI Mailbox and GMAC
 Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sat, 13 Jan 2024 at 12:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 10 Jan 2024 at 23:42, Nabih Estefan <nabihestefan@google.com> wrote:
> >
> > From: Nabih Estefan Diaz <nabihestefan@google.com>
> >
> > [Changes since v11]
> > Was running into error syncing into master. It seemed to be related to a
> > hash problem introduced in patchset 10 (unrelated to the macOS build
> > issue). carried the patches from v9 (before the syncing problem) and
> > added the fixes from patchsets 10 and 11 to remove the hash error.
> >
>
> I found some more issues with this which I've noted in the
> individual patches: in particular the patchset is supposed
> to compile after every patch, and to get that to happen
> a few sections of code needed to be in different patches.
> There were also a couple of other niggles.
>
> However, since the fixes were minor, I have made them myself
> in applying this series to target-arm.next, to save you having
> to do yet another respin.

It turns out that the tests don't pass on a big-endian host.

Some of this is just bugs in the test case code, like this,
where the protocol between the device and the chardev
expects the offset in little-endian byte order but the
test case was not ensuring that:

diff --git a/tests/qtest/npcm7xx_pci_mbox-test.c
b/tests/qtest/npcm7xx_pci_mbox-test.c
index 341642e6371..d1714f44517 100644
--- a/tests/qtest/npcm7xx_pci_mbox-test.c
+++ b/tests/qtest/npcm7xx_pci_mbox-test.c
@@ -101,6 +101,7 @@ static void receive_data(uint64_t offset, uint8_t
*buf, size_t len)
     ssize_t rv;

     while (len > 0) {
+        uint8_t offset_bytes[8];
         uint8_t size;

         if (len >= 8) {
@@ -118,7 +119,8 @@ static void receive_data(uint64_t offset, uint8_t
*buf, size_t len)
         rv = write(fd, &op, 1);
         g_assert_cmpint(rv, ==, 1);
         /* Write offset */
-        rv = write(fd, (uint8_t *)&offset, sizeof(uint64_t));
+        stq_le_p(offset_bytes, offset);
+        rv = write(fd, offset_bytes, sizeof(uint64_t));
         g_assert_cmpint(rv, ==, sizeof(uint64_t));
         /* Write size */
         g_assert_cmpint(write(fd, &size, 1), ==, 1);
@@ -141,6 +143,7 @@ static void send_data(uint64_t offset, const
uint8_t *buf, size_t len)

     while (len > 0) {
         uint8_t size;
+        uint8_t offset_bytes[8];

         if (len >= 8) {
             size = 8;
@@ -157,7 +160,8 @@ static void send_data(uint64_t offset, const
uint8_t *buf, size_t len)
         rv = write(fd, &op, 1);
         g_assert_cmpint(rv, ==, 1);
         /* Write offset */
-        rv = write(fd, (uint8_t *)&offset, sizeof(uint64_t));
+        stq_le_p(offset_bytes, offset);
+        rv = write(fd, offset_bytes, sizeof(uint64_t));
         g_assert_cmpint(rv, ==, sizeof(uint64_t));
         /* Write size */
         g_assert_cmpint(write(fd, &size, 1), ==, 1);


(Side note, if you find yourself casting a uint64_t* to
to a uint8_t* this is almost always a sign of endianness
problems. There are similar casts in the device implementation
which are also flags of problems: see below.)

However this isn't sufficient for the test cases to pass,
because the code in the device itself seems to be confused.
For data sent *to* the device, the OP_WRITE code expects
to see the data in little-endian order, which it then
writes to the guest memory as LE. However for data
read *from* the device, npcm7xx_pci_mbox_send_response()
does not do anything about endianness and so the data
is read from the guest memory as LE and then sent out
on the wire in host-endianness order.

Because I don't know what the intention was here I'm not
going to try to fix this up. Please can you have a look
at this? I would also recommend that you write up somewhere
(even if just in a comment) exactly what the protocol
specification for the on-the-wire format is. That will
make it much easier to determine whether a bug is on the
sending side or the receiving side.


For the other minor stuff which I fixed up locally before
sending the pull request: I suggest that you take the
patches as they appeared there, i.e. patches 10..18 from here:
 https://patchew.org/QEMU/20240116151228.2430754-1-peter.maydell@linaro.org/
But I've just noticed that I seem to have messed up the
author state on some of those patches (probably while I
was squashing patches into each other etc) -- please
check through and correct those back to the original
authorship attribution.

thanks
-- PMM

