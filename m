Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E71027D6E20
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveUQ-0007mg-R1; Wed, 25 Oct 2023 10:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveUO-0007bb-As
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:04:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveUL-0006Ll-5X
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:04:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E560521BDA;
 Wed, 25 Oct 2023 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698242639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSoAWgVIrsSqr2+T9mAqEYsU5ioQVDGRgysWtpYvtEU=;
 b=LoTLdsTD1keKuLAjRTXar+3PIu5Nghf58eOlagXUQPH9/xwkV4e7Zalexiijyy3/FoExs3
 PSkJ/iiv1qX2z5bsE5hl45jGQ4uSl769e5xtTwQoJuoQ0FIVxXuXXkWdGOWV/RwYJZgoQ5
 vHcjpjKPzJxBRcR6Ecrsx5h+eSwHgMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698242639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSoAWgVIrsSqr2+T9mAqEYsU5ioQVDGRgysWtpYvtEU=;
 b=1G+ioMyrb1go7nOpXfBSk11tefOf6pLN+dihE6IteMolA8Ge/2+U6mSaXElxEMgreyRHt3
 L4JbRcfRfGzLWjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76FDD13524;
 Wed, 25 Oct 2023 14:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0YC6EE8gOWUGEgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 14:03:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Nikolay Borisov
 <nborisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, David
 Hildenbrand <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
In-Reply-To: <ZTjiblfeOCTY56e4@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de> <ZTjiblfeOCTY56e4@redhat.com>
Date: Wed, 25 Oct 2023 11:03:57 -0300
Message-ID: <87ttqeer3m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Oct 23, 2023 at 05:35:54PM -0300, Fabiano Rosas wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>>=20
>> Implement the outgoing migration side for the 'fixed-ram' capability.
>>=20
>> A bitmap is introduced to track which pages have been written in the
>> migration file. Pages are written at a fixed location for every
>> ramblock. Zero pages are ignored as they'd be zero in the destination
>> migration as well.
>>=20
>> The migration stream is altered to put the dirty pages for a ramblock
>> after its header instead of having a sequential stream of pages that
>> follow the ramblock headers. Since all pages have a fixed location,
>> RAM_SAVE_FLAG_EOS is no longer generated on every migration iteration.
>>=20
>> Without fixed-ram (current):
>>=20
>> ramblock 1 header|ramblock 2 header|...|RAM_SAVE_FLAG_EOS|stream of
>>  pages (iter 1)|RAM_SAVE_FLAG_EOS|stream of pages (iter 2)|...
>
> Clearer to diagram this vertically I think
>
>  ---------------------
>  | ramblock 1 header |
>  ---------------------
>  | ramblock 2 header |
>  ---------------------
>  | ...               |
>  ---------------------
>  | ramblock n header |
>  ---------------------
>  | RAM_SAVE_FLAG_EOS |
>  ---------------------
>  | stream of pages   |
>  | (iter 1)          |
>  | ...               |
>  ---------------------
>  | RAM_SAVE_FLAG_EOS |
>  ---------------------
>  | stream of pages   |
>  | (iter 2)          |
>  | ...               |
>  ---------------------
>  | ...               |
>  ---------------------
>=20=20
>
>>=20
>> With fixed-ram (new):
>>=20
>> ramblock 1 header|ramblock 1 fixed-ram header|ramblock 1 pages (fixed
>>  offsets)|ramblock 2 header|ramblock 2 fixed-ram header|ramblock 2
>>  pages (fixed offsets)|...|RAM_SAVE_FLAG_EOS
>
> If I'm reading the code correctly the new format has some padding
> such that each "ramblock pages" region starts on a 1 MB boundary.
>
> eg so we get:
>
>  --------------------------------
>  | ramblock 1 header            |
>  --------------------------------
>  | ramblock 1 fixed-ram header  |
>  --------------------------------
>  | padding to next 1MB boundary |
>  | ...                          |
>  --------------------------------
>  | ramblock 1 pages             |
>  | ...                          |
>  --------------------------------
>  | ramblock 2 header            |
>  --------------------------------
>  | ramblock 2 fixed-ram header  |
>  --------------------------------
>  | padding to next 1MB boundary |
>  | ...                          |
>  --------------------------------
>  | ramblock 2 pages             |
>  | ...                          |
>  --------------------------------
>  | ...                          |
>  --------------------------------
>  | RAM_SAVE_FLAG_EOS            |
>  --------------------------------
>  | ...                          |
>  -------------------------------
>
>>=20
>> where:
>>  - ramblock header: the generic information for a ramblock, such as
>>    idstr, used_len, etc.
>>=20
>>  - ramblock fixed-ram header: the new information added by this
>>    feature: bitmap of pages written, bitmap size and offset of pages
>>    in the migration file.
>>=20
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  include/exec/ramblock.h |  8 ++++
>>  migration/options.c     |  3 --
>>  migration/ram.c         | 98 ++++++++++++++++++++++++++++++++++++-----
>>  3 files changed, 96 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
>> index 69c6a53902..e0e3f16852 100644
>> --- a/include/exec/ramblock.h
>> +++ b/include/exec/ramblock.h
>> @@ -44,6 +44,14 @@ struct RAMBlock {
>>      size_t page_size;
>>      /* dirty bitmap used during migration */
>>      unsigned long *bmap;
>> +    /* shadow dirty bitmap used when migrating to a file */
>> +    unsigned long *shadow_bmap;
>> +    /*
>> +     * offset in the file pages belonging to this ramblock are saved,
>> +     * used only during migration to a file.
>> +     */
>> +    off_t bitmap_offset;
>> +    uint64_t pages_offset;
>>      /* bitmap of already received pages in postcopy */
>>      unsigned long *receivedmap;
>>=20=20
>> diff --git a/migration/options.c b/migration/options.c
>> index 2622d8c483..9f693d909f 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -271,12 +271,9 @@ bool migrate_events(void)
>>=20=20
>>  bool migrate_fixed_ram(void)
>>  {
>> -/*
>>      MigrationState *s =3D migrate_get_current();
>>=20=20
>>      return s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM];
>> -*/
>> -    return false;
>>  }
>>=20=20
>>  bool migrate_ignore_shared(void)
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 92769902bb..152a03604f 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1157,12 +1157,18 @@ static int save_zero_page(RAMState *rs, PageSear=
chStatus *pss,
>>          return 0;
>>      }
>>=20=20
>> +    stat64_add(&mig_stats.zero_pages, 1);
>> +
>> +    if (migrate_fixed_ram()) {
>> +        /* zero pages are not transferred with fixed-ram */
>> +        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->shadow_bmap);
>> +        return 1;
>> +    }
>> +
>>      len +=3D save_page_header(pss, file, pss->block, offset | RAM_SAVE_=
FLAG_ZERO);
>>      qemu_put_byte(file, 0);
>>      len +=3D 1;
>>      ram_release_page(pss->block->idstr, offset);
>> -
>> -    stat64_add(&mig_stats.zero_pages, 1);
>>      ram_transferred_add(len);
>>=20=20
>>      /*
>> @@ -1220,14 +1226,20 @@ static int save_normal_page(PageSearchStatus *ps=
s, RAMBlock *block,
>>  {
>>      QEMUFile *file =3D pss->pss_channel;
>>=20=20
>> -    ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
>> -                                         offset | RAM_SAVE_FLAG_PAGE));
>> -    if (async) {
>> -        qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
>> -                              migrate_release_ram() &&
>> -                              migration_in_postcopy());
>> +    if (migrate_fixed_ram()) {
>> +        qemu_put_buffer_at(file, buf, TARGET_PAGE_SIZE,
>> +                           block->pages_offset + offset);
>> +        set_bit(offset >> TARGET_PAGE_BITS, block->shadow_bmap);
>>      } else {
>> -        qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
>> +        ram_transferred_add(save_page_header(pss, pss->pss_channel, blo=
ck,
>> +                                             offset | RAM_SAVE_FLAG_PAG=
E));
>> +        if (async) {
>> +            qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
>> +                                  migrate_release_ram() &&
>> +                                  migration_in_postcopy());
>> +        } else {
>> +            qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
>> +        }
>>      }
>>      ram_transferred_add(TARGET_PAGE_SIZE);
>>      stat64_add(&mig_stats.normal_pages, 1);
>> @@ -2475,6 +2487,8 @@ static void ram_save_cleanup(void *opaque)
>>          block->clear_bmap =3D NULL;
>>          g_free(block->bmap);
>>          block->bmap =3D NULL;
>> +        g_free(block->shadow_bmap);
>> +        block->shadow_bmap =3D NULL;
>>      }
>>=20=20
>>      xbzrle_cleanup();
>> @@ -2842,6 +2856,7 @@ static void ram_list_init_bitmaps(void)
>>               */
>>              block->bmap =3D bitmap_new(pages);
>>              bitmap_set(block->bmap, 0, pages);
>> +            block->shadow_bmap =3D bitmap_new(block->used_length >> TAR=
GET_PAGE_BITS);
>>              block->clear_bmap_shift =3D shift;
>>              block->clear_bmap =3D bitmap_new(clear_bmap_size(pages, shi=
ft));
>>          }
>> @@ -2979,6 +2994,44 @@ void qemu_guest_free_page_hint(void *addr, size_t=
 len)
>>      }
>>  }
>>=20=20
>> +#define FIXED_RAM_HDR_VERSION 1
>> +struct FixedRamHeader {
>> +    uint32_t version;
>> +    uint64_t page_size;
>> +    uint64_t bitmap_offset;
>> +    uint64_t pages_offset;
>> +    /* end of v1 */
>> +} QEMU_PACKED;
>> +
>> +static void fixed_ram_insert_header(QEMUFile *file, RAMBlock *block)
>> +{
>> +    g_autofree struct FixedRamHeader *header;
>> +    size_t header_size, bitmap_size;
>> +    long num_pages;
>> +
>> +    header =3D g_new0(struct FixedRamHeader, 1);
>> +    header_size =3D sizeof(struct FixedRamHeader);
>> +
>> +    num_pages =3D block->used_length >> TARGET_PAGE_BITS;
>> +    bitmap_size =3D BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
>> +
>> +    /*
>> +     * Save the file offsets of where the bitmap and the pages should
>> +     * go as they are written at the end of migration and during the
>> +     * iterative phase, respectively.
>> +     */
>> +    block->bitmap_offset =3D qemu_get_offset(file) + header_size;
>> +    block->pages_offset =3D ROUND_UP(block->bitmap_offset +
>> +                                   bitmap_size, 0x100000);
>
> The 0x100000 gives us our 1 MB alignment.
>
> This is quite an important thing, so can we put a nice clear
> constant at the top of the file:
>
>   /* Align fixed-ram pages data to the next 1 MB boundary */
>   #define FIXED_RAM_PAGE_OFFSET_ALIGNMENT 0x100000
>
>> @@ -3179,7 +3252,6 @@ out:
>>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>>          qemu_fflush(f);
>>          ram_transferred_add(8);
>> -
>>          ret =3D qemu_file_get_error(f);
>>      }
>>      if (ret < 0) {
>
> Supurious whitspace change, possibly better in whatever patch
> introduced it, or dropped ?
>
>
> With regards,
> Daniel

I'll apply all the suggestions. Thanks!

