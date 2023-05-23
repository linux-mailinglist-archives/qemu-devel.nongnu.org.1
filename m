Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FA870D6C7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1N5g-0007DK-Pq; Tue, 23 May 2023 04:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1N5e-0007Cg-9c
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1N5c-00036u-KJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684829391;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DIKluJaHmuaTwQmo7W/iMDiTcLq1CDK6YSD4qLF6zE=;
 b=ZOn6adEB2Qs05EPwyWOYB/FmFZLNSF37+cAO9KI+ZzdoKioPuiaplUgbFHjNXhD/3Ko/1x
 lu0B5Xc6tldtjR5V3Lc2/XPvD4GVTgAomm72DikkAA2nvSXsIvbAIXOTHtLKCAAXDaZhnJ
 kFWAnwbo++BCmWkcC/HdBSuFipsUEdI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Z8oqHFYVOZe8HOwNu1FNRQ-1; Tue, 23 May 2023 04:09:50 -0400
X-MC-Unique: Z8oqHFYVOZe8HOwNu1FNRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4E88800B35;
 Tue, 23 May 2023 08:09:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CD4A9D73;
 Tue, 23 May 2023 08:09:48 +0000 (UTC)
Date: Tue, 23 May 2023 09:09:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, jacek.halon@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
Message-ID: <ZGx0ylB10aLWchuf@redhat.com>
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
 <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, May 22, 2023 at 08:55:02PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/5/23 09:13, Marc-André Lureau wrote:
> > Hi
> > 
> > On Mon, May 8, 2023 at 6:21 PM Mauro Matteo Cascella
> > <mcascell@redhat.com <mailto:mcascell@redhat.com>> wrote:
> > 
> >     The cursor_alloc function still accepts a signed integer for both
> >     the cursor
> >     width and height. A specially crafted negative width/height could
> >     make datasize
> >     wrap around and cause the next allocation to be 0, potentially
> >     leading to a
> >     heap buffer overflow. Modify QEMUCursor struct and cursor_alloc
> >     prototype to
> >     accept unsigned ints.
> > 
> >     Fixes: CVE-2023-1601
> >     Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc
> >     (CVE-2021-4206)")
> >     Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com
> >     <mailto:mcascell@redhat.com>>
> >     Reported-by: Jacek Halon <jacek.halon@gmail.com
> >     <mailto:jacek.halon@gmail.com>>
> > 
> > 
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com
> > <mailto:marcandre.lureau@redhat.com>>
> > 
> > It looks like this is not exploitable, QXL code uses u16 types, and
> 
> 0xffff * 0xffff * 4 still overflows on 32-bit host, right?

cursor_alloc() will reject 0xffff:

    if (width > 512 || height > 512) {
        return NULL;
    }



> 
> > VMWare VGA checks for values > 256. Other paths use fixed size.
> > 
> >     ---
> >       include/ui/console.h | 4 ++--
> >       ui/cursor.c          | 2 +-
> >       2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> >     diff --git a/include/ui/console.h b/include/ui/console.h
> >     index 2a8fab091f..92a4d90a1b 100644
> >     --- a/include/ui/console.h
> >     +++ b/include/ui/console.h
> >     @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
> > 
> >       /* cursor data format is 32bit RGBA */
> >       typedef struct QEMUCursor {
> >     -    int                 width, height;
> >     +    uint32_t            width, height;
> >           int                 hot_x, hot_y;
> >           int                 refcount;
> >           uint32_t            data[];
> >       } QEMUCursor;
> > 
> >     -QEMUCursor *cursor_alloc(int width, int height);
> >     +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
> >       QEMUCursor *cursor_ref(QEMUCursor *c);
> >       void cursor_unref(QEMUCursor *c);
> >       QEMUCursor *cursor_builtin_hidden(void);
> >     diff --git a/ui/cursor.c b/ui/cursor.c
> >     index 6fe67990e2..b5fcb64839 100644
> >     --- a/ui/cursor.c
> >     +++ b/ui/cursor.c
> >     @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
> >           return cursor_parse_xpm(cursor_left_ptr_xpm);
> >       }
> > 
> >     -QEMUCursor *cursor_alloc(int width, int height)
> >     +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
> >       {
> >           QEMUCursor *c;
> 
> Can't we check width/height > 0 && <= SOME_LIMIT_THAT_MAKES_SENSE?
> 
> Maybe a 16K * 16K cursor is future proof and safe enough.
> 
> >           size_t datasize = width * height * sizeof(uint32_t);
> >     --     2.40.1
> > 
> > 
> > 
> > 
> > -- 
> > Marc-André Lureau
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


