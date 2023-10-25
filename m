Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACC67D6E71
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:08:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveXu-0002Zl-P6; Wed, 25 Oct 2023 10:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveXs-0002Zb-Jo
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:07:40 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qveXq-00077O-QD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:07:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2C7421DDC;
 Wed, 25 Oct 2023 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698242856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4cpvH63hjnf2olHsCBuwADsoRGCSj+VWyzb1AX0u3U=;
 b=MuCoVGVOSpxws+HC4vpPZlix1DBvdzClBMZbcG+rZMepqWl5Wv5EywqY+AO/FVK5j9F0Be
 Pbg+v3DacVpWQIB9nNEL8BAPX3YiQT/Yg6gDadpHbvAxe+rcDXFvshrZxW/3F1CxUlzk1C
 7MqMApZ3nmM1Jg67B/nxSsKyTz4jgp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698242856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4cpvH63hjnf2olHsCBuwADsoRGCSj+VWyzb1AX0u3U=;
 b=zPQyFcjLQ1a/ynQ7xPZaU1s5J7rJ+m4C2H7+j4BaCv0cYrxpXyJZZcfE4LVeVfVBQylqSv
 TbojToAAxkbuXGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8453013524;
 Wed, 25 Oct 2023 14:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K9oVFCchOWXUEwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 14:07:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Nikolay Borisov
 <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
In-Reply-To: <ZTjjMiMkmnPMccjq@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de> <ZTjjMiMkmnPMccjq@redhat.com>
Date: Wed, 25 Oct 2023 11:07:33 -0300
Message-ID: <87r0lieqxm.fsf@suse.de>
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
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

> On Mon, Oct 23, 2023 at 05:35:55PM -0300, Fabiano Rosas wrote:
>> From: Nikolay Borisov <nborisov@suse.com>
>>=20
>> Add the necessary code to parse the format changes for the 'fixed-ram'
>> capability.
>>=20
>> One of the more notable changes in behavior is that in the 'fixed-ram'
>> case ram pages are restored in one go rather than constantly looping
>> through the migration stream.
>>=20
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> (farosas) reused more of the common code by making the fixed-ram
>> function take only one ramblock and calling it from inside
>> parse_ramblock.
>> ---
>>  migration/ram.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>=20
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 152a03604f..cea6971ab2 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3032,6 +3032,32 @@ static void fixed_ram_insert_header(QEMUFile *fil=
e, RAMBlock *block)
>>      qemu_put_buffer(file, (uint8_t *) header, header_size);
>>  }
>>=20=20
>> +static int fixed_ram_read_header(QEMUFile *file, struct FixedRamHeader =
*header)
>> +{
>> +    size_t ret, header_size =3D sizeof(struct FixedRamHeader);
>> +
>> +    ret =3D qemu_get_buffer(file, (uint8_t *)header, header_size);
>> +    if (ret !=3D header_size) {
>> +        return -1;
>> +    }
>> +
>> +    /* migration stream is big-endian */
>> +    be32_to_cpus(&header->version);
>> +
>> +    if (header->version > FIXED_RAM_HDR_VERSION) {
>> +        error_report("Migration fixed-ram capability version mismatch (=
expected %d, got %d)",
>> +                     FIXED_RAM_HDR_VERSION, header->version);
>> +        return -1;
>> +    }
>> +
>> +    be64_to_cpus(&header->page_size);
>> +    be64_to_cpus(&header->bitmap_offset);
>> +    be64_to_cpus(&header->pages_offset);
>> +
>> +
>> +    return 0;
>> +}
>> +
>>  /*
>>   * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
>>   * long-running RCU critical section.  When rcu-reclaims in the code
>> @@ -3932,6 +3958,68 @@ void colo_flush_ram_cache(void)
>>      trace_colo_flush_ram_cache_end();
>>  }
>>=20=20
>> +static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
>> +                                    long num_pages, unsigned long *bitm=
ap)
>> +{
>> +    unsigned long set_bit_idx, clear_bit_idx;
>> +    unsigned long len;
>> +    ram_addr_t offset;
>> +    void *host;
>> +    size_t read, completed, read_len;
>> +
>> +    for (set_bit_idx =3D find_first_bit(bitmap, num_pages);
>> +         set_bit_idx < num_pages;
>> +         set_bit_idx =3D find_next_bit(bitmap, num_pages, clear_bit_idx=
 + 1)) {
>> +
>> +        clear_bit_idx =3D find_next_zero_bit(bitmap, num_pages, set_bit=
_idx + 1);
>> +
>> +        len =3D TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
>> +        offset =3D set_bit_idx << TARGET_PAGE_BITS;
>> +
>> +        for (read =3D 0, completed =3D 0; completed < len; offset +=3D =
read) {
>> +            host =3D host_from_ram_block_offset(block, offset);
>> +            read_len =3D MIN(len, TARGET_PAGE_SIZE);
>> +
>> +            read =3D qemu_get_buffer_at(f, host, read_len,
>> +                                      block->pages_offset + offset);
>> +            completed +=3D read;
>> +        }
>> +    }
>> +}
>> +
>> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_a=
ddr_t length)
>> +{
>> +    g_autofree unsigned long *bitmap =3D NULL;
>> +    struct FixedRamHeader header;
>> +    size_t bitmap_size;
>> +    long num_pages;
>> +    int ret =3D 0;
>> +
>> +    ret =3D fixed_ram_read_header(f, &header);
>> +    if (ret < 0) {
>> +        error_report("Error reading fixed-ram header");
>> +        return -EINVAL;
>> +    }
>> +
>> +    block->pages_offset =3D header.pages_offset;
>
> Do you think it is worth sanity checking that 'pages_offset' is aligned
> in some way.
>
> It is nice that we have flexibility to change the alignment in future
> if we find 1 MB is not optimal, so I wouldn't want to force 1MB align
> check htere. Perhaps we could at least sanity check for alignment at
> TARGET_PAGE_SIZE, to detect a gross data corruption problem ?
>

I don't see why not. I'll add it.


