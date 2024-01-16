Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104C82E9BF
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:00:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdPg-0005EM-U7; Tue, 16 Jan 2024 01:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdPc-0005EB-IM
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdPa-000766-Kb
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705388341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pniEmMA6k0xobLPU9RjPvydP0Kh1IVSHAr/M2DqdWZA=;
 b=eoN0vB18uS58FO8eWOP5NLpHF5OXHS75Lf4A2IVGY7XV7bfyTCq2xXVNs5OlcXoNdOy2E0
 58ODdcKk9Yc7FBtW2Eak/4p8G0NrtEB4LKYtU3jb/N8VTxcJO5iFzqn81qJoqaQIatFndA
 XEhgHBhZSpAqANY6TIKRqmW8FiHufU8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-sQTeHsP9NrysZS3offQZBg-1; Tue, 16 Jan 2024 01:59:00 -0500
X-MC-Unique: sQTeHsP9NrysZS3offQZBg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d9b3a964a1so2430538b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 22:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705388339; x=1705993139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pniEmMA6k0xobLPU9RjPvydP0Kh1IVSHAr/M2DqdWZA=;
 b=sIiIO5Au3INaQZZi94qgYfbFGtTuwRWl91DUysKaesQgbp6J326XJTBHoV4r1OnMEy
 U3MIVbzKK/vFZLyHYZEL8IiMfgDvpq3md6Og0USgSkvqNLF8fKIO9Pmx7VcirCH9Hj7u
 tAny+03t5sumfphFG7aMKxmy3p0gR4LUYrDmD6/MBRNSeq146A46Ts/o+fElKzI26ELi
 vj8fDj8dpp2lQZGC2ZfhxXMA4kfy8geC2XZY+1KU/kBbq3ChRRCD23arsNSeLEW9q/Ig
 kBHolnKC2BGOu26CpKvWD2XfEBaF2R7ZS7le1+Qi5LEa15XAVvmLPtwh1aHUkSi9qPpH
 ZhWw==
X-Gm-Message-State: AOJu0YwrD3NorkVtiC2rTwJ3B/fljKZrkPBea88NaaZ341mO4uHBlqqW
 Li/cFOUvKknjchjFJ8ephoF07TmM4Lj7lxX1vycP4HHlLfExavTumdHPwvqIRVZKiqc/kaMd6SN
 72rg0Bgvkmls7YRnvnx34WGM=
X-Received: by 2002:a05:6a20:2e1f:b0:196:16b0:c554 with SMTP id
 be31-20020a056a202e1f00b0019616b0c554mr10099455pzb.5.1705388338977; 
 Mon, 15 Jan 2024 22:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzT74j83YZGqtK/hLLGXJEbtPbGXLLCmR+oRMGlC/0zUuhSvur1bn2IdieL4Vb3TRID1oVNA==
X-Received: by 2002:a05:6a20:2e1f:b0:196:16b0:c554 with SMTP id
 be31-20020a056a202e1f00b0019616b0c554mr10099445pzb.5.1705388338622; 
 Mon, 15 Jan 2024 22:58:58 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 cz13-20020a17090ad44d00b0028c8a2a9c73sm11082192pjb.25.2024.01.15.22.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 22:58:58 -0800 (PST)
Date: Tue, 16 Jan 2024 14:58:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 15/30] io: Add a pwritev/preadv version that takes
 a discontiguous iovec
Message-ID: <ZaYpKorhxEi3CEmv@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 27, 2023 at 05:25:57PM -0300, Fabiano Rosas wrote:
> For the upcoming support to fixed-ram migration with multifd, we need
> to be able to accept an iovec array with non-contiguous data.
> 
> Add a pwritev and preadv version that splits the array into contiguous
> segments before writing. With that we can have the ram code continue
> to add pages in any order and the multifd code continue to send large
> arrays for reading and writing.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - split the API that was merged into a single function
> - use uintptr_t for compatibility with 32-bit
> ---
>  include/io/channel.h | 26 ++++++++++++++++
>  io/channel.c         | 70 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 96 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 7986c49c71..25383db5aa 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -559,6 +559,19 @@ int qio_channel_close(QIOChannel *ioc,
>  ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
>                              size_t niov, off_t offset, Error **errp);
>  
> +/**
> + * qio_channel_pwritev_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to write data from
> + * @niov: the length of the @iov array
> + * @offset: the iovec offset in the file where to write the data
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Returns: 0 if all bytes were written, or -1 on error
> + */
> +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
> +                            size_t niov, off_t offset, Error **errp);
> +
>  /**
>   * qio_channel_pwrite
>   * @ioc: the channel object
> @@ -595,6 +608,19 @@ ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
>  ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
>                             size_t niov, off_t offset, Error **errp);
>  
> +/**
> + * qio_channel_preadv_all:
> + * @ioc: the channel object
> + * @iov: the array of memory regions to read data to
> + * @niov: the length of the @iov array
> + * @offset: the iovec offset in the file from where to read the data
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Returns: 0 if all bytes were read, or -1 on error
> + */
> +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
> +                           size_t niov, off_t offset, Error **errp);
> +
>  /**
>   * qio_channel_pread
>   * @ioc: the channel object
> diff --git a/io/channel.c b/io/channel.c
> index a1f12f8e90..2f1745d052 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -472,6 +472,69 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
>      return klass->io_pwritev(ioc, iov, niov, offset, errp);
>  }
>  
> +static int qio_channel_preadv_pwritev_contiguous(QIOChannel *ioc,
> +                                                 const struct iovec *iov,
> +                                                 size_t niov, off_t offset,
> +                                                 bool is_write, Error **errp)
> +{
> +    ssize_t ret = -1;
> +    int i, slice_idx, slice_num;
> +    uintptr_t base, next, file_offset;
> +    size_t len;
> +
> +    slice_idx = 0;
> +    slice_num = 1;
> +
> +    /*
> +     * If the iov array doesn't have contiguous elements, we need to
> +     * split it in slices because we only have one (file) 'offset' for
> +     * the whole iov. Do this here so callers don't need to break the
> +     * iov array themselves.
> +     */
> +    for (i = 0; i < niov; i++, slice_num++) {
> +        base = (uintptr_t) iov[i].iov_base;
> +
> +        if (i != niov - 1) {
> +            len = iov[i].iov_len;
> +            next = (uintptr_t) iov[i + 1].iov_base;
> +
> +            if (base + len == next) {
> +                continue;
> +            }
> +        }
> +
> +        /*
> +         * Use the offset of the first element of the segment that
> +         * we're sending.
> +         */
> +        file_offset = offset + (uintptr_t) iov[slice_idx].iov_base;
> +
> +        if (is_write) {
> +            ret = qio_channel_pwritev(ioc, &iov[slice_idx], slice_num,
> +                                      file_offset, errp);
> +        } else {
> +            ret = qio_channel_preadv(ioc, &iov[slice_idx], slice_num,
> +                                     file_offset, errp);
> +        }
> +
> +        if (ret < 0) {
> +            break;
> +        }
> +
> +        slice_idx += slice_num;
> +        slice_num = 0;
> +    }
> +
> +    return (ret < 0) ? -1 : 0;
> +}
> +
> +int qio_channel_pwritev_all(QIOChannel *ioc, const struct iovec *iov,
> +                            size_t niov, off_t offset, Error **errp)
> +{
> +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
> +                                                 offset, true, errp);
> +}

I'm not sure how Dan thinks about this, but I don't think this is pretty..

With this implementation, iochannels' preadv/pwritev is completely not
compatible with most OSes now, afaiu.

The definition of offset in preadv/pwritev of current iochannel is hard to
understand.. if I read it right it'll later be set to:
      
                /*
                 * If we subtract the host page now, we don't need to
                 * pass it into qio_channel_pwritev_all() below.
                 */
                write_base = p->pages->block->pages_offset -
                    (uintptr_t)p->pages->block->host;

Which I cannot easily tell what it is.. besides being an unsigned int.

IIUC it's also based on the assumption that the host address of each iov
entry is linear to its offset in the file, but it may not be true for
future iochannel users of such interface called as pwritev/preadv.  So
error prone.

Would it be possible we keep using the offset array (p->pages->offset[x])?
We have it already anyway, right?  Wouldn't that be clearer?

It doesn't need to be called pwritev/preadv, but taking two arrays: the
host address array and another offset array on that file.  It can still do
the range merge, do another sanity check on the offsets to make sure the
offsets are also continuous (and should be true in our case).

> +
>  ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
>                             off_t offset, Error **errp)
>  {
> @@ -501,6 +564,13 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
>      return klass->io_preadv(ioc, iov, niov, offset, errp);
>  }
>  
> +int qio_channel_preadv_all(QIOChannel *ioc, const struct iovec *iov,
> +                           size_t niov, off_t offset, Error **errp)
> +{
> +    return qio_channel_preadv_pwritev_contiguous(ioc, iov, niov,
> +                                                 offset, false, errp);
> +}
> +
>  ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
>                            off_t offset, Error **errp)
>  {
> -- 
> 2.35.3
> 

-- 
Peter Xu


