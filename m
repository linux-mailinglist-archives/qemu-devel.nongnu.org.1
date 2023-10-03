Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2F7B7311
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:10:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmdj-00052C-JQ; Tue, 03 Oct 2023 17:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmdh-00051x-Pf
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmdg-0000uS-4f
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696367345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hogiBUlIhtdukuY0kOvY51knAwTBrTIs91zb79aESI=;
 b=eIJZNM5FK9ukPa6zA+tavcLjPEbUQ5tQYlCFO6/H92gAh3/D/vyd/HcBMfnFGKKiI/aaJz
 20QomeZ0G6SJlF0gRN0pfidX6WJs/syaAvcpKTzzNJwFOrp57+Tq87SscBTF00Zenj1d7Z
 K5Ac99MA9rAZgP1ebhc8mGaYBrDJBsw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-q3VNaWDfOD6oCotv-3df9g-1; Tue, 03 Oct 2023 17:09:04 -0400
X-MC-Unique: q3VNaWDfOD6oCotv-3df9g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4197468d5caso4080271cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696367343; x=1696972143;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9hogiBUlIhtdukuY0kOvY51knAwTBrTIs91zb79aESI=;
 b=vpLK0tKZjALgRZZ8lmljT03hPdylsNJ/OvGbROd7D5WECbT4ZOiHQbu7druJKmfo2j
 bdFW56lDuTscc9Qhw1QurFpzFnclEDShHkS5Q+uYp1TWWkVw4p8Ic1rhZTKqHtl8zgTl
 VohZInP6CtWSQ5RdqmUDAw5sCYCcQjIDNh5BBt58uBSlFjExgh1uzee8trHbxfNPT3r9
 tDtunkXSgON13vkJNyS5IsDDkQ3H/BUd8chBa6yyt22wotPHg15wv/O3BVwqzoSrdzd1
 VE0CjI/6mdHxi1wShbfDNZgAuI1IwLx5Ms/vLWk9poPgiDwzBqPTWfTvjzJ+t3Zpju8l
 1CAg==
X-Gm-Message-State: AOJu0Yy8B5twh3dcFbb6HfMxGGp5QH30csHEOrw1HqCUXd3TnxaadVz6
 HkiY30fCRUOe65P36IyyJU3uz4e1W2pqzARFW1vK47cVf6aaX4wZ42UsHrG8/cpeQhCFwj91O06
 pdycWmUpxE5gMs/I=
X-Received: by 2002:ad4:5949:0:b0:65d:484:9d0f with SMTP id
 eo9-20020ad45949000000b0065d04849d0fmr484058qvb.3.1696367343458; 
 Tue, 03 Oct 2023 14:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOruZV4Ekl2lh7NkVkGTv/IQbxTEPWPz6qr2POojz+TCc0W6LpPvuBJN/CFyiKstLq7kpCFA==
X-Received: by 2002:ad4:5949:0:b0:65d:484:9d0f with SMTP id
 eo9-20020ad45949000000b0065d04849d0fmr484048qvb.3.1696367343207; 
 Tue, 03 Oct 2023 14:09:03 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c15-20020a0ce14f000000b0065d04135014sm792265qvl.13.2023.10.03.14.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 14:09:02 -0700 (PDT)
Date: Tue, 3 Oct 2023 17:08:55 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH] analyze-migration: ignore RAM_SAVE_FLAG_MULTIFD_FLUSH
Message-ID: <ZRyC5+juhdOrP73K@x1n>
References: <20230926081819.433631-1-marcandre.lureau@redhat.com>
 <CAJ+F1C+r3Nz9vCUhkzRAdsGPZexW8ivcO2E=CFK1jhkUvOfPxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+r3Nz9vCUhkzRAdsGPZexW8ivcO2E=CFK1jhkUvOfPxA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 02:32:37PM +0400, Marc-André Lureau wrote:
> On Tue, Sep 26, 2023 at 12:19 PM <marcandre.lureau@redhat.com> wrote:
> >
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> > Traceback (most recent call last):
> >   File "scripts/analyze-migration.py", line 605, in <module>
> >     dump.read(dump_memory = args.memory)
> >   File "scripts/analyze-migration.py", line 542, in read
> >     section.read()
> >   File "scripts/analyze-migration.py", line 214, in read
> >     raise Exception("Unknown RAM flags: %x" % flags)
> > Exception: Unknown RAM flags: 200
> >
> > See commit 77c259a4cb ("multifd: Create property multifd-flush-after-each-section")
> >
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> cc Peter and Juan

Sorry to be late..

It's actually a bug to have MULTIFD_FLUSH in the stream in the first place,
though..  the fix to make that MULTIFD_FLUSH disappear should be in Juan's
next pull.

IIUC logically analyze-migration.py shouldn't be able to understand
multifd, because it relies on a solo stream file, while multifd is already
against it.  We plan to add "file:" support for multifd, but even with that
I doubt whether there'll be MULTIFD_FLUSH kept in the final file because
it's only used to sync threads.

Thanks,

> 
> > ---
> >  scripts/analyze-migration.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> > index b82a1b0c58..082424558b 100755
> > --- a/scripts/analyze-migration.py
> > +++ b/scripts/analyze-migration.py
> > @@ -111,6 +111,8 @@ class RamSection(object):
> >      RAM_SAVE_FLAG_CONTINUE = 0x20
> >      RAM_SAVE_FLAG_XBZRLE   = 0x40
> >      RAM_SAVE_FLAG_HOOK     = 0x80
> > +    RAM_SAVE_FLAG_COMPRESS_PAGE = 0x100
> > +    RAM_SAVE_FLAG_MULTIFD_FLUSH = 0x200
> >
> >      def __init__(self, file, version_id, ramargs, section_key):
> >          if version_id != 4:
> > @@ -205,6 +207,8 @@ def read(self):
> >                  raise Exception("XBZRLE RAM compression is not supported yet")
> >              elif flags & self.RAM_SAVE_FLAG_HOOK:
> >                  raise Exception("RAM hooks don't make sense with files")
> > +            if flags & self.RAM_SAVE_FLAG_MULTIFD_FLUSH:
> > +                continue
> >
> >              # End of RAM section
> >              if flags & self.RAM_SAVE_FLAG_EOS:
> > --
> > 2.41.0
> >
> >
> 
> 
> -- 
> Marc-André Lureau
> 

-- 
Peter Xu


