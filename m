Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDFF82AB6C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:58:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrog-0004cj-LV; Thu, 11 Jan 2024 04:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNrof-0004cX-2U
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNrod-0004QF-C4
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704967054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dPj3JtZqc9usteK72d2TofCzQY26EVdJ0A9R6VcqKA=;
 b=MRZVy2xDZGDKV4Nml3O1Mh1CYFinVk94RZ1up1D3i36vUDbxquBK8RgWte4gxDswpL/WaZ
 MkzPFoFxcx1+VxjQW65jrrV8vj+2cAHU//tb8I1MG+2tUdWqhAetH2ryDCYE0zpZd9gdPd
 o0pr9CrCIG7Go/XC4lUkLAFRSFmoyAU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-ROjRpTTGP1GBlmGXJl-ePg-1; Thu, 11 Jan 2024 04:57:25 -0500
X-MC-Unique: ROjRpTTGP1GBlmGXJl-ePg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28cb02a6027so1076684a91.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 01:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704967044; x=1705571844;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5dPj3JtZqc9usteK72d2TofCzQY26EVdJ0A9R6VcqKA=;
 b=u6A1o8XTGY37iaEIEjfnuLRYv2tcZZUDphZIfPhScwByesB5DIfqJVG/Ybc2W6Ihc+
 tHdnLyhwKcE/Vlx7rGlJBqeyULnpTjgKDGUbEvhxLOwGBC9NoGKQuS05knFS58wLlAbY
 JXbM+rX6zg0Q3ZHS89tQTZ9wiuKn6lzGwL+KAZvIFPeNDP7lfe/YPu3fb48toYXzDdjR
 wZklzeVnJ+9vhl0XnPJpylqehEgl2x5yXaoN8pxIAwWKJDbBCZr85srmDXJ8Iiz0fGKV
 wj5CY4sCfdSaKfzJLqnHz7XKCGmwP7MFvKZXebttMmj+Cf3oyso6eCqlHHHchLXyStfb
 ieRw==
X-Gm-Message-State: AOJu0YxhkzKoQFwVwS48kdFYnMx/DolOC4ioroyp8NLcHD+O+Do4+MQx
 bDx/uuA4Iz5dCFk6Rz+2FvRp2WpMRZtdJg+lv/FaNeYvkyymePTB7eTt4zt87G5etMt46K87uXD
 rjxFeMey0rQ7uJELdO+o9Ets=
X-Received: by 2002:a17:90b:1c86:b0:28c:ef1a:db19 with SMTP id
 oo6-20020a17090b1c8600b0028cef1adb19mr1657646pjb.0.1704967044130; 
 Thu, 11 Jan 2024 01:57:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkhGdSclYcejNRmGQETfflvjbNEm2Oeh4fVBi0Q9A6sJjcbzn9jOBH7zHJI0xNq9Hw/AE+ow==
X-Received: by 2002:a17:90b:1c86:b0:28c:ef1a:db19 with SMTP id
 oo6-20020a17090b1c8600b0028cef1adb19mr1657634pjb.0.1704967043746; 
 Thu, 11 Jan 2024 01:57:23 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 pl7-20020a17090b268700b0028d0b013880sm3319342pjb.0.2024.01.11.01.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 01:57:23 -0800 (PST)
Date: Thu, 11 Jan 2024 17:57:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 05/30] migration/qemu-file: add utility methods
 for working with seekable channels
Message-ID: <ZZ-7ehYiGcvlHQmz@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127202612.23012-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 27, 2023 at 05:25:47PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Add utility methods that will be needed when implementing 'fixed-ram'
> migration capability.
> 
> qemu_file_is_seekable
> qemu_put_buffer_at
> qemu_get_buffer_at
> qemu_set_offset
> qemu_get_offset
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/migration/qemu-file-types.h |  2 +
>  migration/qemu-file.c               | 82 +++++++++++++++++++++++++++++
>  migration/qemu-file.h               |  6 +++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
> index 9ba163f333..adec5abc07 100644
> --- a/include/migration/qemu-file-types.h
> +++ b/include/migration/qemu-file-types.h
> @@ -50,6 +50,8 @@ unsigned int qemu_get_be16(QEMUFile *f);
>  unsigned int qemu_get_be32(QEMUFile *f);
>  uint64_t qemu_get_be64(QEMUFile *f);
>  
> +bool qemu_file_is_seekable(QEMUFile *f);
> +
>  static inline void qemu_put_be64s(QEMUFile *f, const uint64_t *pv)
>  {
>      qemu_put_be64(f, *pv);
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 94231ff295..faf6427b91 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -33,6 +33,7 @@
>  #include "options.h"
>  #include "qapi/error.h"
>  #include "rdma.h"
> +#include "io/channel-file.h"
>  
>  #define IO_BUF_SIZE 32768
>  #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
> @@ -255,6 +256,10 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>      memset(f->may_free, 0, sizeof(f->may_free));
>  }
>  
> +bool qemu_file_is_seekable(QEMUFile *f)
> +{
> +    return qio_channel_has_feature(f->ioc, QIO_CHANNEL_FEATURE_SEEKABLE);
> +}
>  
>  /**
>   * Flushes QEMUFile buffer
> @@ -447,6 +452,83 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>      }
>  }
>  
> +void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
> +                        off_t pos)
> +{
> +    Error *err = NULL;
> +
> +    if (f->last_error) {
> +        return;
> +    }
> +
> +    qemu_fflush(f);
> +    qio_channel_pwrite(f->ioc, (char *)buf, buflen, pos, &err);

Partial writes won't set err.  Do we want to check the retval here too and
fail properly if detected partial writes?

> +
> +    if (err) {
> +        qemu_file_set_error_obj(f, -EIO, err);
> +    } else {
> +        stat64_add(&mig_stats.qemu_file_transferred, buflen);

buflen is only accurate if with above, iiuc.

> +    }
> +
> +    return;
> +}
> +
> +
> +size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
> +                          off_t pos)
> +{
> +    Error *err = NULL;
> +    ssize_t ret;
> +
> +    if (f->last_error) {
> +        return 0;
> +    }
> +
> +    ret = qio_channel_pread(f->ioc, (char *)buf, buflen, pos, &err);

Same question here.

> +    if (ret == -1 || err) {
> +        goto error;
> +    }
> +
> +    return (size_t)ret;
> +
> + error:
> +    qemu_file_set_error_obj(f, -EIO, err);
> +    return 0;
> +}
> +
> +void qemu_set_offset(QEMUFile *f, off_t off, int whence)
> +{
> +    Error *err = NULL;
> +    off_t ret;
> +
> +    qemu_fflush(f);
> +
> +    if (!qemu_file_is_writable(f)) {
> +        f->buf_index = 0;
> +        f->buf_size = 0;
> +    }

There's the qemu_file_is_writable() check after all, then put qemu_fflush()
into condition too?

  if (qemu_file_is_writable(f)) {
      qemu_fflush(f);
  } else {
     /* Drop all the cached buffers if existed; will trigger a re-fill later */
     f->buf_index = 0;
     f->buf_size = 0;
  }

> +
> +    ret = qio_channel_io_seek(f->ioc, off, whence, &err);
> +    if (ret == (off_t)-1) {
> +        qemu_file_set_error_obj(f, -EIO, err);
> +    }
> +}
> +
> +off_t qemu_get_offset(QEMUFile *f)
> +{
> +    Error *err = NULL;
> +    off_t ret;
> +
> +    qemu_fflush(f);
> +
> +    ret = qio_channel_io_seek(f->ioc, 0, SEEK_CUR, &err);
> +    if (ret == (off_t)-1) {
> +        qemu_file_set_error_obj(f, -EIO, err);
> +    }
> +    return ret;
> +}
> +
> +
>  void qemu_put_byte(QEMUFile *f, int v)
>  {
>      if (f->last_error) {
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 8aec9fabf7..32fd4a34fd 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -75,6 +75,12 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
>  int qemu_fflush(QEMUFile *f);
>  void qemu_file_set_blocking(QEMUFile *f, bool block);
>  int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
> +void qemu_set_offset(QEMUFile *f, off_t off, int whence);
> +off_t qemu_get_offset(QEMUFile *f);
> +void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
> +                        off_t pos);
> +size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
> +                          off_t pos);
>  
>  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


