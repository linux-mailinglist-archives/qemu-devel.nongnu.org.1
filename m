Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DE68300C8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:53:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0j0-0005oU-DL; Wed, 17 Jan 2024 02:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ0iz-0005o7-4g
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:52:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQ0ix-0001S4-8y
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705477954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgrKPNzucU8YRwi8mmkm3PbYta7FW7msw1iiwYHrUUU=;
 b=GobxC25TEOwa8NVS43wKtyFcnupQ59L2o9lFK+aJR4YLN5I/59uFZGQPz12vs0Y80opluP
 cM0iA8j9fKCbGT9NXtrmQcLYwlHKqs5rXDSmgozpD5MAjl46rXycfZHZrLbWb/0H0/alpZ
 M0CZwI0UA8Y5n/EExgwecSE8L8ff5/c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-n6JWID98OEu0A3w2b8d-ig-1; Wed, 17 Jan 2024 02:52:31 -0500
X-MC-Unique: n6JWID98OEu0A3w2b8d-ig-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so2926079b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477951; x=1706082751;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgrKPNzucU8YRwi8mmkm3PbYta7FW7msw1iiwYHrUUU=;
 b=w6RdqM8eX9WOm/AAZOFtsA2z2Yof65h7um3ZteogNzmQwDl6iyyKSF252Yo1bz+6oF
 IjRxeuoMXheFSDzlovO6Au7wN0Qmi23n6YtIeMQLxcRue0dHJKppCsg28CBtbSSgkkmS
 rPEoq7l3d6j/+nnswzzOKDT/yift3wyi2ePMgaAyZLJNVdjZvGuCtyJV7sWh2iVsUq61
 TUlj+DjmKuKLO4P0XFzSkP/1veBdZiwRQ63C5zBxzuSxXc6aqRSTb1YwiiRukwAJoW3m
 8ovBK1XgO92mxtiQPaQxrRooz78jWBRfWB5K7/qRoiPfCKUcfN46GZAw+MIK0XMf+CTq
 IAQg==
X-Gm-Message-State: AOJu0Yw68oHMNVN+hc7sMtKecAOHKkqUv5n0Ngg4anIvvTwleoYNSeNC
 Djp/Cvaziruj0RYT/G2KmD5tUlxkZG8RK2DZ0HV7K1ZpdrFsEXpXD7ONPkTLRJCm35f4RJcVcq9
 NwLnVeTNkXcJDC1wjwdoL/dk=
X-Received: by 2002:a05:6a20:2e1f:b0:196:16b0:c554 with SMTP id
 be31-20020a056a202e1f00b0019616b0c554mr12891195pzb.5.1705477950743; 
 Tue, 16 Jan 2024 23:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvn0I4d4fY4O/d2Q1Ux+Ev27J2pfSuuZXtbvD/FrkU8o+kaiZ6HUheYIc1IZZqxrdNsCKX0g==
X-Received: by 2002:a05:6a20:2e1f:b0:196:16b0:c554 with SMTP id
 be31-20020a056a202e1f00b0019616b0c554mr12891181pzb.5.1705477950433; 
 Tue, 16 Jan 2024 23:52:30 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 eu15-20020a17090af94f00b0028c9d359011sm13239670pjb.32.2024.01.16.23.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:29 -0800 (PST)
Date: Wed, 17 Jan 2024 15:52:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 2/2] hw/pflash: implement update buffer for block writes
Message-ID: <ZaeHOCHTs0-ivm4j@x1n>
References: <20240108125342.48298-1-philmd@linaro.org>
 <20240108125342.48298-3-philmd@linaro.org>
 <39ff1c41-c7ea-4cdc-ab18-b299b91cafb8@linaro.org>
 <CAFEAcA8ZMHwKeEmwakt9BHt5Z_0DihYXtfTP-sOSBnt2dv6hWg@mail.gmail.com>
 <4b7fe91d-9e96-4de4-af6f-c9be81c43ab1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b7fe91d-9e96-4de4-af6f-c9be81c43ab1@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 16, 2024 at 05:08:28PM +0100, Philippe Mathieu-Daudé wrote:
> On 12/1/24 17:54, Peter Maydell wrote:
> > On Mon, 8 Jan 2024 at 13:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > > 
> > > Hi Gerd,
> > > 
> > > On 8/1/24 13:53, Philippe Mathieu-Daudé wrote:
> > > > From: Gerd Hoffmann <kraxel@redhat.com>
> > > > 
> > > > Add an update buffer where all block updates are staged.
> > > > Flush or discard updates properly, so we should never see
> > > > half-completed block writes in pflash storage.
> > > > 
> > > > Drop a bunch of FIXME comments ;)
> > > > 
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > Message-ID: <20240105135855.268064-3-kraxel@redhat.com>
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > >    hw/block/pflash_cfi01.c | 106 ++++++++++++++++++++++++++++++----------
> > > >    1 file changed, 80 insertions(+), 26 deletions(-)
> 
> 
> > > > +static const VMStateDescription vmstate_pflash_blk_write = {
> > > > +    .name = "pflash_cfi01_blk_write",
> > > > +    .version_id = 1,
> > > > +    .minimum_version_id = 1,
> > > > +    .needed = pflash_blk_write_state_needed,
> > > > +    .fields = (const VMStateField[]) {
> > > > +        VMSTATE_VBUFFER_UINT32(blk_bytes, PFlashCFI01, 0, NULL, writeblock_size),
> > > 
> > > I don't get the difference with VMSTATE_VBUFFER_ALLOC_UINT32() which
> > > sets VMS_ALLOC. In this case pflash_cfi01_realize() does the alloc so
> > > we don't need VMS_ALLOC?
> > 
> > Yes, that's the idea. A VMS_ALLOC vmstate type means "this
> > block of memory is dynamically sized at runtime, so when the
> > migration code is doing inbound migration it needs to
> > allocate a buffer of the right size first (based on some
> > state struct field we've already migrated) and then put the
> > incoming data into it". VMS_VBUFFER means "the size of the buffer
> > isn't a compile-time constant, so we need to fish it out of
> > some other state struct field". So:
> > 
> >   VMSTATE_VBUFFER_UINT32: we need to migrate (a pointer to) an array
> >   of uint32_t; the size of that is in some other struct field,
> >   but it's a runtime constant and we can assume the memory has
> >   already been allocated
> > 
> >   VMSTATE_VBUFFER_ALLOC_UINT32: we need to migrate an array
> >   of uint32_t of variable size dependent on the inbound migration
> >   data, and so the migration code must allocate it
> 
> Thanks Peter!
> 
> Do you mind if we commit your explanation as is? As:

Any attempt to provide more documents there for the macros would be nice if
anyone would like to post a patch.  Though some comments below for this
specific one.

> 
> -- >8 --
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 294d2d8486..5c6f6c5c32 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -573,4 +573,6 @@ extern const VMStateInfo vmstate_info_qlist;
> 
> -/* a variable length array (i.e. _type *_field) but we know the
> - * length
> +/**
> + * VMSTATE_STRUCT_VARRAY_POINTER_KNOWN:
> + *
> + * A variable length array (i.e. _type *_field) but we know the length.
>   */
> @@ -678,2 +680,10 @@ extern const VMStateInfo vmstate_info_qlist;
> 
> +/**
> + * VMSTATE_VBUFFER_UINT32:
> + *
> + * We need to migrate (a pointer to) an array of uint32_t; the size of

IIUC it's not an array of uint32_t, but a buffer with dynamic size.  the
"uint32_t" is trying to describe the type of the size field, afaict.  Same
issue for below one.

For example, comparing VMSTATE_VBUFFER_UINT32 vs VMSTATE_VBUFFER, we should
see the only difference is:

    .size_offset  = vmstate_offset_value(_state, _field_size, int32_t),\

vs:

    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\

I think it checks the size field to match that type.

Interestingly, when I look at the code to use the size, it looks like a bug
to me, where we always parse the size field to be int32_t..

static int vmstate_size(void *opaque, const VMStateField *field)
{
    int size = field->size;

    if (field->flags & VMS_VBUFFER) {
        size = *(int32_t *)(opaque + field->size_offset);     <----------- see here..
        if (field->flags & VMS_MULTIPLY) {
            size *= field->size;
        }
    }

    return size;
}

I think it'll start to crash things when bit32 start to be used.  And I had
a feeling that this is overlooked in the commit a19cbfb346 ("spice: add qxl
device") where VMSTATE_VBUFFER_UINT32 is introduced.

I don't have a good way to trivially fix it because we don't remember that
type of size in vmsd.  However a simple solution could be that we convert
all existing VMSTATE_VBUFFER() (potentially, VMSTATE_PARTIAL_VBUFFER users;
there seems to have only 1 caller..) to always use uint32_t.  I don't think
it's wise to try using a signed for size anyway, and it should be
compatible change as we doubled the size.

I'll hold a bit to see whether there's some comment, then I can try to post
a patch.

> + * that is in some other struct field, but it's a runtime constant and
> + * we can assume the memory has already been allocated.
> +*/
> +
>  #define VMSTATE_VBUFFER_UINT32(_field, _state, _version, _test,
> _field_size) { \
> @@ -688,2 +698,9 @@ extern const VMStateInfo vmstate_info_qlist;
> 
> +/**
> + * VMSTATE_VBUFFER_ALLOC_UINT32:
> + *
> + * We need to migrate an array of uint32_t of variable size dependent
> + * on the inbound migration data, and so the migration code must
> + * allocate it.
> +*/
>  #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
> ---
> 

-- 
Peter Xu


