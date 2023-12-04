Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C1804143
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 23:05:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAH34-0005uM-Ss; Mon, 04 Dec 2023 17:04:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAH31-0005u7-A4
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 17:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAH2z-0006zU-Fl
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 17:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701727452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/X+Wumm9vNLxnOdiGpdsjuZJtTsoDCWDDeZguFiLNp8=;
 b=fcqhh4D0f7W8+KECC9UgbDumDh01ozfpHg587uR0Y+d2jZabYWw96xOZiD2f7rqolAhyUZ
 cbWrfB3kxZVdovxJgz2YqKq4zxUI1c7NJRHEAd3XrqnNIxFJWxSjXbv1FQcGDY9Itr0MTO
 v7ZNYO0/aMlReryFGNP6H9A9Ht1agK0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-drMRo8fhPLeZXYrVZU8FUw-1; Mon, 04 Dec 2023 17:04:10 -0500
X-MC-Unique: drMRo8fhPLeZXYrVZU8FUw-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7b3d03b59adso143609739f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 14:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701727450; x=1702332250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/X+Wumm9vNLxnOdiGpdsjuZJtTsoDCWDDeZguFiLNp8=;
 b=kqv6/xVwpVy3wwxVPmsgxr+lddDHXWOmzfVYu2fzjGq5HkoNrOmldXYJbdntKcgbqm
 A/JkptV+fKL3HImAigOEPw8LzKr6p2h9EyZTo62O0CPAbquvJUft3Nvx6tLKJwRbvECc
 iMszGstfhqISWODIF7NGsesOya+VnGXQ4G5gsa+0KOE+r0C4cDQZJvFCVSUWVEmHrrpm
 3PchV03nhbb+28ajCMH8LWXFJ2kanpTjX8FZYOcjqeBJDBVMJ4dRnMBbl74PdiGW3SBY
 nrgOtRj7uv8haV4ORvYIsdnzhHCQ351gaw9SgCaSXgDzwtxTE0BzjBQ7YSif1J0zw8Ns
 4kBw==
X-Gm-Message-State: AOJu0Ywz6F6cjcAYl6Z3c/nGqKv+ysCJ77FaLZW78hcjQTFXgtwcwgCY
 goGNg16+HPBVhHr2+JchZGCe6dlDoPEqtDXcqe7Mxn+3ywRQWsFZufIVIMK3EAUpX/HHmyzPdeh
 XuSLKTXuS5vHkPxQ=
X-Received: by 2002:a6b:c403:0:b0:7b3:f2a2:45e with SMTP id
 y3-20020a6bc403000000b007b3f2a2045emr17368772ioa.2.1701727450103; 
 Mon, 04 Dec 2023 14:04:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIcCklP7piAJzrWKZyv8bVMHa9P+EIIdl0zvAn7V3TOkRiPLM5vGI8pOW34Pr3egXYSzSRrQ==
X-Received: by 2002:a6b:c403:0:b0:7b3:f2a2:45e with SMTP id
 y3-20020a6bc403000000b007b3f2a2045emr17368757ioa.2.1701727449785; 
 Mon, 04 Dec 2023 14:04:09 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 a7-20020a5d9807000000b007b3e07371bbsm2993765iol.19.2023.12.04.14.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 14:04:09 -0800 (PST)
Date: Mon, 4 Dec 2023 17:04:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Message-ID: <ZW5M19173nTZTLv1@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n>
 <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n> <87r0k1n4r7.fsf@suse.de>
 <ZW4wTK0dld9pPCtX@x1n> <87o7f5n08z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7f5n08z.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Dec 04, 2023 at 06:09:16PM -0300, Fabiano Rosas wrote:
> Right, I got your point. I just think we could avoid designing this new
> string format by creating new fields with the extra space:
> 
> typedef struct QEMU_PACKED {
>     uint32_t size;
>     uint8_t runstate[50];
>     uint8_t unused[50];
>     RunState state;
>     bool received;
> } GlobalState;
> 
> In my mind this works seamlessly, or am I mistaken?

I think what you proposed should indeed work.

Currently it's:

    .fields = (VMStateField[]) {
        VMSTATE_UINT32(size, GlobalState),
        VMSTATE_BUFFER(runstate, GlobalState),
        VMSTATE_END_OF_LIST()
    },

I had a quick look at vmstate_info_buffer, it mostly only get()/put() those
buffers with its sizeof(), so looks all fine.  For sure in all cases we'd
better test it to verify.

One side note is since we so far use qapi_enum_parse() for the runstate, I
think the "size" is not ever used..

If we do want a split, IMHO we can consider making runstate[] even smaller
to just free up the rest spaces all in one shot:

  typedef struct QEMU_PACKED {
      uint32_t size;
      /*
       * Assuming 16 is good enough to fit all possible runstate strings..
       * This field must be a string ending with '\0'.
       */
      uint8_t runstate[16];
      /* 0x00 when QEMU doesn't support it, or "0"/"1" to reflect its state */
      uint8_t vm_was_suspended[1];
      /*
       * Still free of use space.  Note that we only have 99 bytes for use
       * because the last byte (the 100th byte) must be zero due to legacy
       * reasons, if not it may be set to zero after loaded on dest QEMU. 
       */
      uint8_t unused[82];
      RunState state;
      bool received;
  } GlobalState;

Pairs with something like:

    .fields = (VMStateField[]) {
        /* Used to be "size" but never used on dest, so always ignored */
        VMSTATE_UNUSED(4),
        VMSTATE_BUFFER(runstate, GlobalState),
        VMSTATE_BUFFER(vm_was_suspended, GlobalState),
        /*
         * This is actually all zeros, but just to differenciate from the
         * last byte..
         */
        VMSTATE_BUFFER(unused, GlobalState),
        /*
         * For historical reasons, the last byte must be 0x00 or it'll be
         * overwritten by old qemu otherwise.
         */
        VMSTATE_UNUSED(1),
        VMSTATE_END_OF_LIST()
    },

> 
> In any case, a oneshot hack might be better than both our suggestions
> because we can just clean it up a couple of releases from now as if
> nothing happened.

It can be forgotten forever, then we keep the code less readable.  If we
have a plan to do that and not so awkward, IMHO we should go directly with
that plan.

Thanks,

-- 
Peter Xu


