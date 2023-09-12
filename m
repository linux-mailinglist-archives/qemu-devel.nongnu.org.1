Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B579D177
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2vY-0004G3-2N; Tue, 12 Sep 2023 08:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1qfxhp-0007CX-DF
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:21:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1qfxhj-0000zu-WF
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:21:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so36495635ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1694503257; x=1695108057;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t8gkAD2Tox161Vy4sOVhwXN6LH6F1WwZDOdwPXWAuHM=;
 b=W34U3ZKHMweS+I1sqy7tjZRafLmxAmYDFvOiJstYGlRmFh+a/A9rvOR1RmYeiMcLXa
 7H6RCg7cEcYK/URKqX0v2FTW/GhiQfzhJCsVRRuUthb8KUZjqiYcEOCiRO5TxhfReVSW
 X1k53nlk/wWrYpTDhRgPpPf2Jgqjix12b7cRxpl0XimuUFyrUI55qBkCADhtbSZY6aow
 cdGV+uJFJkshfZHVzUwqi2MIgPjc1k5iekhpmgEpvNHZuJ1z2TAbiVQ7lgr1LCDiqQxO
 W+oNj8SSxWDh7r0h0CbJ+bq8E7OaZeE9aicrJAqbTzxOhTMkR0ORdbC4w4t+TlZ63vEG
 Zfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694503257; x=1695108057;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t8gkAD2Tox161Vy4sOVhwXN6LH6F1WwZDOdwPXWAuHM=;
 b=rWV1PvBPUdBy6jDIOMr4EPwc55ntst7kGEJoYLZ+E7SHYCmJyNuYOTai8/d7RaUscL
 cg9HSvnxQDLMQhxMG41WKmw8HJx+KcPz7VQKczrXKEWPm+WEuwNnxn5Gb6dZ5N7P2s2o
 DqC1XqNrbvRV7mUCw3BVSvXDO6e400uXEfIXXODuV1Pg+J5MNyTwATNMkEGXicdc/lPe
 K2N+4uJkt40EAz5Vg6k9zsbaQF6mVqEBJBqNvwXLReVM8A6EwMIhItZPzcVcYllD4/AD
 SXoAUF7gY6dFqOl4fCg1Z86srEiWWnZvsRa5oNbCAmrHPSu2WuJi7VbG9cZLJf8+H+iF
 NI3A==
X-Gm-Message-State: AOJu0YwVntG66tB6NTzOwdD7pXoyl/jnhZt9UNhIAvUqyxrmW78Gu/fs
 m5QrN+ts39j9nMtmiu4u4P6+7Q==
X-Google-Smtp-Source: AGHT+IEEPxTunVCEfBdJY4FTl5TagWG77q1m8GyOEI9y62BgvvtEN5tmjPf+I2VX82jCaw5oLI9G/w==
X-Received: by 2002:a17:902:d501:b0:1c3:22a9:8643 with SMTP id
 b1-20020a170902d50100b001c322a98643mr2499690plg.31.1694503256818; 
 Tue, 12 Sep 2023 00:20:56 -0700 (PDT)
Received: from telecaster ([2601:602:a300:3bc0::2928])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a170902c18d00b001a5260a6e6csm7649534pld.206.2023.09.12.00.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:20:56 -0700 (PDT)
Date: Tue, 12 Sep 2023 00:20:55 -0700
From: Omar Sandoval <osandov@osandov.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 linux-debuggers@vger.kernel.org, joao.m.martins@oracle.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened
 format when necessary
Message-ID: <ZQARV6fJ0N0QyTk1@telecaster>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com> <87fs4aha4t.fsf@oracle.com>
 <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
 <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=osandov@osandov.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Sep 2023 08:55:22 -0400
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

On Tue, Sep 12, 2023 at 10:34:04AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Aug 23, 2023 at 2:03 PM Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Wed, Aug 23, 2023 at 4:31 AM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> > >
> > > Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > > > Marc-André Lureau <marcandre.lureau@gmail.com> writes:
> > > >> I am a bit reluctant to change the dump format by default. But since the
> > > >> flatten format is more "complicated" than the "normal" format, perhaps we
> > > >> can assume all users will handle it.
> > > >>
> > > >> The change is probably late for 8.1 though..
> > > >
> > > > Thank you for your review and testing!
> > > >
> > > > I totally understand the concern about making the change by default. I
> > > > do believe that nobody should notice too much because the normal format
> > > > should be easier to work with, and more broadly compatible. I don't know
> > > > of any tool which deals with the flattened format that can't handle the
> > > > normal format, except for "makedumpfile -R" itself.
> > > >
> > > > If it's a blocker, I can go ahead and add a new flag to the command to
> > > > enable the behavior. However there are a few good justifications not to
> > > > add a new flag. I think it's going to be difficult to explain the
> > > > difference between the two formats in documentation, as the
> > > > implementation of the formats is a bit "into the weeds". The libvirt API
> > > > also specifies each format separately (kdump-zlib, kdump-lzo,
> > > > kdump-snappy) and so adding several new options there would be
> > > > unfortunate for end-users as well.
> > > >
> > > > At the end of the day, it's your judgment call, and I'll implement it
> > > > how you prefer.
> > >
> > > I just wanted to check back on this to clarify the next step. Are you
> > > satisfied with this and waiting to apply it until the right time? Or
> > > would you prefer me to send a new version making this opt-in?
> > >
> >
> > Nobody seems to raise concerns. If it would be just me, I would change
> > it. But we should rather be safe, so let's make it this opt-in please.
> >
> >
> 
> Alex, Daniel, Thomas .. Do you have an opinion on changing the dump format?

Chiming in as a user here, but I'd much prefer for the normal format to
be the default. The last time that I tried dump-guest-memory with the
kdump format, it took me awhile to figure out what format it was
actually using since libkdumpfile didn't understand it.

