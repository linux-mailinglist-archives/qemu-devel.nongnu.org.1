Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E647E2433
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:19:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzUb-0005Pc-Vy; Mon, 06 Nov 2023 08:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qzzUZ-0005Nf-Ss
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:18:12 -0500
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qzzUX-0000RA-Ri
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:18:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 077571FE46;
 Mon,  6 Nov 2023 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699276686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12IfxXmkhGkj4DqROHGHnXiO7Yj5dpAToesWxRk9Qh4=;
 b=uO5bGaI7wSCSNs8TU4MqeFjPfDQOkPZ3kN9tLH09ORX3KY4OXcp67mDG5+8vw8oXe8wdPe
 g/jyX2RwGO7lQFaUHiwNeU5cf9Z2fLXV7gTKAcPvd/QHZu0+13kQlRRjB5z2djUgVUjvRY
 K/o4NH7JAYQCzhnEOnfAjjRvfQLYp48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699276686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12IfxXmkhGkj4DqROHGHnXiO7Yj5dpAToesWxRk9Qh4=;
 b=DpH8wI7fRPH2GLXOQc7msxB6KR7SpR+f3qh91FjeSeHLYb/DCklGrcWUztLtlSJwbDqcTy
 oLscIHF/BgkE0GCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DF2D138E5;
 Mon,  6 Nov 2023 13:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r5eWFo3nSGU8ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 06 Nov 2023 13:18:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>, Claudio Fontana
 <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
In-Reply-To: <ZUJn/5GuRXcudsiF@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de> <ZTjjMiMkmnPMccjq@redhat.com>
 <87r0lieqxm.fsf@suse.de> <ZUFPlqgFx/2MeCj8@x1n>
 <ZUIZ1g5UahLu4pXh@redhat.com> <ZUJe0xb2Q0HgzBX+@x1n>
 <ZUJgiHa2gTCdhWZ1@redhat.com> <ZUJn/5GuRXcudsiF@x1n>
Date: Mon, 06 Nov 2023 10:18:03 -0300
Message-ID: <871qd3dnqs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Nov 01, 2023 at 02:28:24PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Nov 01, 2023 at 10:21:07AM -0400, Peter Xu wrote:
>> > On Wed, Nov 01, 2023 at 09:26:46AM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
>> > > On Tue, Oct 31, 2023 at 03:03:50PM -0400, Peter Xu wrote:
>> > > > On Wed, Oct 25, 2023 at 11:07:33AM -0300, Fabiano Rosas wrote:
>> > > > > >> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *b=
lock, ram_addr_t length)
>> > > > > >> +{
>> > > > > >> +    g_autofree unsigned long *bitmap =3D NULL;
>> > > > > >> +    struct FixedRamHeader header;
>> > > > > >> +    size_t bitmap_size;
>> > > > > >> +    long num_pages;
>> > > > > >> +    int ret =3D 0;
>> > > > > >> +
>> > > > > >> +    ret =3D fixed_ram_read_header(f, &header);
>> > > > > >> +    if (ret < 0) {
>> > > > > >> +        error_report("Error reading fixed-ram header");
>> > > > > >> +        return -EINVAL;
>> > > > > >> +    }
>> > > > > >> +
>> > > > > >> +    block->pages_offset =3D header.pages_offset;
>> > > > > >
>> > > > > > Do you think it is worth sanity checking that 'pages_offset' i=
s aligned
>> > > > > > in some way.
>> > > > > >
>> > > > > > It is nice that we have flexibility to change the alignment in=
 future
>> > > > > > if we find 1 MB is not optimal, so I wouldn't want to force 1M=
B align
>> > > > > > check htere. Perhaps we could at least sanity check for alignm=
ent at
>> > > > > > TARGET_PAGE_SIZE, to detect a gross data corruption problem ?
>> > > > > >
>> > > > >=20
>> > > > > I don't see why not. I'll add it.
>> > > >=20
>> > > > Is there any explanation on why that 1MB offset, and how the numbe=
r is
>> > > > chosen?  Thanks,
>> > >=20
>> > > The fixed-ram format is anticipating the use of O_DIRECT.
>> > >=20
>> > > With O_DIRECT both the buffers in memory, and the file handle offset
>> > > have alignment requirements. The buffer alignments are usually page
>> > > sized, and QEMU RAM blocks will trivially satisfy those.
>> > >=20
>> > > The file handle offset alignment varies per filesystem. While you can
>> > > query the alignment for the FS holding the file with statx(), that is
>> > > not appropriate todo. If a user saves/restores QEMU state to file, we
>> > > must assume there is a chance the user will copy the saved state to a
>> > > different filesystem.
>> > >=20
>> > > IOW, we want alignment to satisfy the likely worst case.
>> > >=20
>> > > Picking 1 MB is a nice round number that is large enough that it is
>> > > almost certainly going to satisfy any filesystem alignment. In fact
>> > > it is likely massive overkill. None the less 1 MB is also still tiny
>> >=20
>> > Is that calculated by something like max of possible host (small) page
>> > sizes?  I've no idea what's it for all archs, the max small page size =
I'm
>> > aware of is 64K, but I don't know a lot archs.
>>=20
>> It wasn't anything as precise as that. It is literally just "1MB" looks
>> large enough that we don't need to spend time to investigate per arch
>> page sizes.
>
> IMHO we need that precision on reasoning and document it, even if not on
> the exact number we prefer, which can be prone to change later.  Otherwise
> that value will be a pure magic soon after a few years or even less, it'll
> be more of a challenge later to figure things out.
>
>>=20
>> Having said that I'm now having slight self-doubt wrt huge pages, though
>> I swear we investigated it last year when first discussing this feature.
>> The guest memory will of course already be suitably aligned, but I'm
>> wondering if the filesystem I/O places any offset alignment constraints
>> related to non-default page size.
>
> AFAIU direct IO is about pinning the IO buffers, playing the role of fs
> cache instead.  If my understanding is correct, huge pages shouldn't be a
> problem for such pinning, because it's legal to pin partial of a huge pag=
e.
>
> After the partial huge pages pinned, they should be treated as normal fs
> buffers when doing block IO.  And then the offset of file should, per my
> understanding, not relevant to what is the type of backend of that user
> buffer anymore that triggers read()/write().
>
> But maybe I missed something, if so that will need to be part of
> documentation of 1MB magic value, IMHO.  We may want to double check with
> that by doing fixed-ram migration on e.g. 1GB hugetlb memory-backend-file
> with 1MB file offset per-ramblock.

Does anyone have any indication that we need to relate the aligment to
the page size? All I find online points to device block size being the
limiting factor for filesystems. There's also raw_probe_alignment() at
file-posix.c which seems to check up to 4k and recommend to disable
O_DIRECT if an alignment is not found.

Note that we shouldn't have any problems changing the alignment we
choose since we have a pointer to the start of the aligned region which
goes along with the fixed-ram header. We could even do some probing like
the block layer does if we wanted.

