Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A331FBFBD1F
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Oct 2025 14:20:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoa-0001JA-NC; Wed, 22 Oct 2025 08:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBXoY-0001HH-5W
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBXoU-00074s-Bm
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BTlXK6QWPT2X38klUfuM15mNNxRnAvRMmuyeoGriiqM=;
 b=PQX7iJK/RzbOyervoR7MIMZEKuvES8nlZO0WCjeBnH+hmgYh3Ymhsqri2mqwsvmfCrC/9X
 juevDlt2PXcPVvHQzjgJ/v4LdDI8Rg4uubvZbFdyQfV4+puWUMcUmpw0Tlr1u9JkjjmDOi
 aSjVIUILEKdj8NqyzbQX2WwnSlnwRIs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-o6K5j5gCNjm5kp9R6_ZmVg-1; Wed,
 22 Oct 2025 08:19:29 -0400
X-MC-Unique: o6K5j5gCNjm5kp9R6_ZmVg-1
X-Mimecast-MFC-AGG-ID: o6K5j5gCNjm5kp9R6_ZmVg_1761135568
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1F8019540EA; Wed, 22 Oct 2025 12:19:28 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.168])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21DAC1955E88; Wed, 22 Oct 2025 12:19:25 +0000 (UTC)
Date: Wed, 22 Oct 2025 14:19:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 13/21] fuse: Manually process requests (without libfuse)
Message-ID: <aPjLywlk8LyerNna@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-14-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701114437.207419-14-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
> Manually read requests from the /dev/fuse FD and process them, without
> using libfuse.  This allows us to safely add parallel request processing
> in coroutines later, without having to worry about libfuse internals.
> (Technically, we already have exactly that problem with
> read_from_fuse_export()/read_from_fuse_fd() nesting.)
> [...]

> +/**
> + * Write a FUSE response to the given @fd, using a single buffer consecutively
> + * containing both the response header and data: Initialize *out_hdr, and write
> + * it plus @response_data_length consecutive bytes to @fd.
> + *
> + * @fd: FUSE file descriptor
> + * @req_id: Corresponding request ID
> + * @out_hdr: Pointer to buffer that will hold the output header, and
> + *           additionally already contains @response_data_length data bytes
> + *           starting at *out_hdr + 1.
> + * @err: Error code (-errno, or 0 in case of success)
> + * @response_data_length: Length of data to return (following *out_hdr)
> + */
> +static int fuse_write_response(int fd, uint32_t req_id,
> +                               struct fuse_out_header *out_hdr, int err,
> +                               size_t response_data_length)
> +{
> +    void *write_ptr = out_hdr;
> +    size_t to_write = sizeof(*out_hdr) + response_data_length;
> +    ssize_t ret;
> +
> +    *out_hdr = (struct fuse_out_header) {
> +        .len = to_write,
> +        .error = err,
> +        .unique = req_id,
> +    };
> +
> +    while (true) {
> +        ret = RETRY_ON_EINTR(write(fd, write_ptr, to_write));
> +        if (ret < 0) {
> +            ret = -errno;
> +            error_report("Failed to write to FUSE device: %s", strerror(-ret));
> +            return ret;
> +        } else {
> +            to_write -= ret;
> +            if (to_write > 0) {
> +                write_ptr += ret;
> +            } else {
> +                return 0; /* success */
> +            }
> +        }
> +    }
> +}

Two thoughts on this one:

This looks like essentially a reimplementation of qemu_write_full(),
except that it doesn't count how many bytes were successfully written
until the error happened. Is this sufficiently different to exist?

And do we even need to consider short writes? I would be surprised if
FUSE let that happen. libfuse doesn't seem to consider it an option, it
just calls writev() once in fuse_write_msg_dev(). And indeed, the kernel
returns either an error or the full byte count in fuse_dev_do_write().

> +/**
> + * Write a FUSE response to the given @fd, using separate buffers for the
> + * response header and data: Initialize *out_hdr, and write it plus the data in
> + * *buf to @fd.
> + *
> + * In contrast to fuse_write_response(), this function cannot return errors, and
> + * will always return success (error code 0).
> + *
> + * @fd: FUSE file descriptor
> + * @req_id: Corresponding request ID
> + * @out_hdr: Pointer to buffer that will hold the output header
> + * @buf: Pointer to response data
> + * @buflen: Length of response data
> + */
> +static int fuse_write_buf_response(int fd, uint32_t req_id,
> +                                   struct fuse_out_header *out_hdr,
> +                                   const void *buf, size_t buflen)
> +{
> +    struct iovec iov[2] = {
> +        { out_hdr, sizeof(*out_hdr) },
> +        { (void *)buf, buflen },
> +    };
> +    struct iovec *iovp = iov;
> +    unsigned iov_count = ARRAY_SIZE(iov);
> +    size_t to_write = sizeof(*out_hdr) + buflen;
> +    ssize_t ret;
> +
> +    *out_hdr = (struct fuse_out_header) {
> +        .len = to_write,
> +        .unique = req_id,
> +    };
> +
> +    while (true) {
> +        ret = RETRY_ON_EINTR(writev(fd, iovp, iov_count));
> +        if (ret < 0) {
> +            ret = -errno;
> +            error_report("Failed to write to FUSE device: %s", strerror(-ret));
> +            return ret;
> +        } else {
> +            to_write -= ret;
> +            if (to_write > 0) {
> +                iov_discard_front(&iovp, &iov_count, ret);
> +            } else {
> +                return 0; /* success */
> +            }
> +        }
> +    }
> +}

Same question as above (except that a qemu_writev_full() doesn't exist
yet if we decided that for some reason short writes really are a
concern).

> +/*
> + * For use in fuse_process_request():
> + * Returns a pointer to the parameter object for the given operation (inside of
> + * export->request_buf, which is assumed to hold a fuse_in_header first).
> + * Verifies that the object is complete (export->request_buf is large enough to
> + * hold it in one piece, and the request length includes the whole object).
> + *
> + * Note that export->request_buf may be overwritten after polling, so the
> + * returned pointer must not be used across a function that may poll!
> + */
> +#define FUSE_IN_OP_STRUCT(op_name, export) \
> +    ({ \
> +        const struct fuse_in_header *__in_hdr = \
> +            (const struct fuse_in_header *)(export)->request_buf; \
> +        const struct fuse_##op_name##_in *__in = \
> +            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
> +        const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
> +        uint32_t __req_len; \
> +        \
> +        QEMU_BUILD_BUG_ON(sizeof((export)->request_buf) < __param_len); \
> +        \
> +        __req_len = __in_hdr->len; \
> +        if (__req_len < __param_len) { \
> +            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
> +                        __req_len, __param_len); \
> +            ret = -EINVAL; \
> +            break; \
> +        } \
> +        __in; \
> +    })
> +
> +/*
> + * For use in fuse_process_request():
> + * Returns a pointer to the return object for the given operation (inside of
> + * out_buf, which is assumed to hold a fuse_out_header first).
> + * Verifies that out_buf is large enough to hold the whole object.
> + *
> + * (out_buf should be a char[] array.)
> + */
> +#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
> +    ({ \
> +        struct fuse_out_header *__out_hdr = \
> +            (struct fuse_out_header *)(out_buf); \
> +        struct fuse_##op_name##_out *__out = \
> +            (struct fuse_##op_name##_out *)(__out_hdr + 1); \
> +        \
> +        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
> +                          sizeof(out_buf)); \
> +        \
> +        __out; \
> +    })
> +
> +/**
> + * Process a FUSE request, incl. writing the response.
> + *
> + * Note that polling in any request-processing function can lead to a nested
> + * read_from_fuse_fd() call, which will overwrite the contents of
> + * exp->request_buf.  Anything that takes a buffer needs to take care that the
> + * content is copied before potentially polling.
> + */
> +static void fuse_process_request(FuseExport *exp)
> +{
> +    uint32_t opcode;
> +    uint64_t req_id;
> +    /*
> +     * Return buffer.  Must be large enough to hold all return headers, but does
> +     * not include space for data returned by read requests.
> +     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is indeed
> +     * large enough.)
> +     */
> +    char out_buf[sizeof(struct fuse_out_header) +
> +                 MAX_CONST(sizeof(struct fuse_init_out),
> +                 MAX_CONST(sizeof(struct fuse_open_out),
> +                 MAX_CONST(sizeof(struct fuse_attr_out),
> +                 MAX_CONST(sizeof(struct fuse_write_out),
> +                           sizeof(struct fuse_lseek_out)))))];

This and the macros above are a little ugly. Can't we just define a type
for this? Something like this:

struct {
    struct fuse_out_header header;
    union {
        struct fuse_init_out init;
        struct fuse_open_out open;
        struct fuse_attr_out attr;
        struct fuse_write_out write;
        struct fuse_lseek_out lseek;
    };
};

And then have a variable of that type here. Instead of
FUSE_OUT_OP_STRUCT(), you can now just access the union members.

For FUSE_IN_OP_STRUCT(), there's the additional length check that you
have, so maybe for that one, the macro still has its use.

> +    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
> +    /* For read requests: Data to be returned */
> +    void *out_data_buffer = NULL;
> +    ssize_t ret;
> +
> +    /* Limit scope to ensure pointer is no longer used after polling */
> +    {
> +        const struct fuse_in_header *in_hdr =
> +            (const struct fuse_in_header *)exp->request_buf;
> +
> +        opcode = in_hdr->opcode;
> +        req_id = in_hdr->unique;
> +    }
> +
> +    switch (opcode) {
> +    case FUSE_INIT: {
> +        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, exp);
> +        ret = fuse_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
> +                        in->max_readahead, in->flags);
> +        break;
> +    }
> +
> +    case FUSE_OPEN:
> +        ret = fuse_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
> +        break;
> +
> +    case FUSE_RELEASE:
> +        ret = 0;
> +        break;
> +
> +    case FUSE_LOOKUP:
> +        ret = -ENOENT; /* There is no node but the root node */
> +        break;
> +
> +    case FUSE_GETATTR:
> +        ret = fuse_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
> +        break;
> +
> +    case FUSE_SETATTR: {
> +        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, exp);
> +        ret = fuse_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
> +                           in->valid, in->size, in->mode, in->uid, in->gid);
> +        break;
> +    }
> +
> +    case FUSE_READ: {
> +        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, exp);
> +        ret = fuse_read(exp, &out_data_buffer, in->offset, in->size);
> +        break;
> +    }
> +
> +    case FUSE_WRITE: {
> +        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, exp);
> +        uint32_t req_len;
> +
> +        req_len = ((const struct fuse_in_header *)exp->request_buf)->len;

Hm, was that the idea when you limited the in_hdr scope above? :-)

> +        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
> +                               in->size)) {
> +            warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
> +                        req_len - sizeof(struct fuse_in_header) - sizeof(*in),
> +                        in->size);
> +            ret = -EINVAL;
> +            break;
> +        }
> +
> +        /*
> +         * poll_fuse_fd() has checked that in_hdr->len matches the number of
> +         * bytes read, which cannot exceed the max_write value we set
> +         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
> +         * in_hdr->len >= in->size + X, so this assertion must hold.
> +         */
> +        assert(in->size <= FUSE_MAX_WRITE_BYTES);
> +
> +        /*
> +         * Passing a pointer to `in` (i.e. the request buffer) is fine because
> +         * fuse_write() takes care to copy its contents before potentially
> +         * polling.
> +         */
> +        ret = fuse_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
> +                         in->offset, in->size, in + 1);
> +        break;
> +    }
> +
> +    case FUSE_FALLOCATE: {
> +        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, exp);
> +        ret = fuse_fallocate(exp, in->offset, in->length, in->mode);
> +        break;
> +    }
> +
> +    case FUSE_FSYNC:
> +        ret = fuse_fsync(exp);
> +        break;
> +
> +    case FUSE_FLUSH:
> +        ret = fuse_flush(exp);
> +        break;
> +
>  #ifdef CONFIG_FUSE_LSEEK
> -    .lseek      = fuse_lseek,
> +    case FUSE_LSEEK: {
> +        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, exp);
> +        ret = fuse_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
> +                         in->offset, in->whence);
> +        break;
> +    }
>  #endif
> -};
> +
> +    default:
> +        ret = -ENOSYS;
> +    }
> +
> +    /* Ignore errors from fuse_write*(), nothing we can do anyway */
> +    if (out_data_buffer) {
> +        assert(ret >= 0);
> +        fuse_write_buf_response(exp->fuse_fd, req_id, out_hdr,
> +                                out_data_buffer, ret);
> +        qemu_vfree(out_data_buffer);
> +    } else {
> +        fuse_write_response(exp->fuse_fd, req_id, out_hdr,
> +                            ret < 0 ? ret : 0,
> +                            ret < 0 ? 0 : ret);
> +    }
> +}

In summary, I don't really see anything wrong, but just some things that
maybe look more complicated than strictly necessarily.

Kevin


