Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5617B9B67
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:32:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIqD-0003vk-Vx; Thu, 05 Oct 2023 03:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoIq7-0003tV-MC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoIq6-00070H-AU
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696491125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UH6dQBMnYCYqWlxsMWP7NrmDPSYlhNhmtwVyQv6flbk=;
 b=CErrK4f8R+NMb34c6in8pPOfDPAjhqkeY1EFVYYI1yEW0HmzhbnjTqp+FijOn9/vyNAB+J
 eZ9u/q/TRGxzmrwLPH1wywReW2P95ElAX8qQwiY7/46YLzl8BFCRFhGhQ3xyM97vaTKjM7
 Rd7OsBDVFgZJx5rr8hQbNVGTglzD+X8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-Dp9wr4RtNlm0Ufz77JjSNg-1; Thu, 05 Oct 2023 03:32:04 -0400
X-MC-Unique: Dp9wr4RtNlm0Ufz77JjSNg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-406de77fb85so868285e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696491122; x=1697095922;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UH6dQBMnYCYqWlxsMWP7NrmDPSYlhNhmtwVyQv6flbk=;
 b=R5lKvf6nwm6mh1Q+GuWr6zpAgz3k/6gmEB9UbkB6QGrvRUE3mCEOetVqZrheX7K+nP
 3yXDKu/kGnv4EQSN/HFIY5KZ8KlNAJ0uQIHf7TxCXfNDoFmw8PC1rh3bU0OCwo+j4SFI
 AQPskOsyhP4jeaw8MYhFq6T+JWdaydP9XfEX2pV64DeJQ2iWPSo82pnmKX8NXgQOOV1K
 WqR8YBbEIH5r2ejBzUnRdQTrPjMts0pe5LdRNI7YDj1mMccas7YXKP4muKGw/+tT/apu
 mI1Zw4cxb1Nivl+RKun6Lt1v7tmjntJiSjP7RuidvfDI/vK4bc4RNOC1QPyCTJEzsBkl
 hCXA==
X-Gm-Message-State: AOJu0YzlIn1WVTwvSz2UBrAM2hIcgDLgN1a4FpyYAYLhNyJ07UqP6N6M
 XSeJjmeXkwssDGTJEAgzvAXdBB7YEr6DJZmKtASvafMBhqQ9lodjfpGWUAsWaHhi6geRDD/gCx+
 5aM33WiDJrVOTVjE=
X-Received: by 2002:a05:600c:231a:b0:405:3a14:aa1a with SMTP id
 26-20020a05600c231a00b004053a14aa1amr4371097wmo.18.1696491121983; 
 Thu, 05 Oct 2023 00:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFamXB0oo9zd0DJjXKH8OzGhgFv3Uf3VCer+2GoL4ozODEfu0RZVxXQ6Cp0RFELLLpqrF2ADQ==
X-Received: by 2002:a05:600c:231a:b0:405:3a14:aa1a with SMTP id
 26-20020a05600c231a00b004053a14aa1amr4371087wmo.18.1696491121711; 
 Thu, 05 Oct 2023 00:32:01 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c22c600b0040303a9965asm3114796wmg.40.2023.10.05.00.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 00:32:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 04/10] migration: Deliver return path file error to
 migrate state too
In-Reply-To: <20231004220240.167175-5-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:34 -0400")
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-5-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 09:32:00 +0200
Message-ID: <87il7lplsf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> We've already did this for most of the return path thread errors, but not
> yet for the IO errors happened on the return path qemufile.  Do that too.
>
> Re-export qemu_file_get_error_obj().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


