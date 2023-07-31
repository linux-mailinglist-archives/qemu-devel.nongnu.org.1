Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7A769EC7
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 19:08:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQWMC-00006Q-42; Mon, 31 Jul 2023 13:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQWM5-000063-E2
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQWM3-0000EG-VJ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 13:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690823206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ezZ4BiSM9otoFB/6u1ScMq73QfaXtnbvKJH7lPNVLo=;
 b=Oag27CXTozbcSidL2Xs4IA6Nab6V6wYvmxYu/PDx7HK7pWWZqOb9eCQ6aF9hA0/lr9iLhO
 zz/TStmu3rRX9Y27dDOoY3nq1oOUKuDgdrKpplJUiGkAL3nClPhQPT3S5G+jXUplDvCUZc
 EWrFnl5IL5zZfMJWOiFfB+PjOJZaMlA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-hHi66qOWPOiD9WxM3P8BvQ-1; Mon, 31 Jul 2023 13:06:44 -0400
X-MC-Unique: hHi66qOWPOiD9WxM3P8BvQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40fa24ab5c8so2535351cf.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 10:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690823204; x=1691428004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ezZ4BiSM9otoFB/6u1ScMq73QfaXtnbvKJH7lPNVLo=;
 b=eJJuWWQLQbWpd6lZWuc4DM+2GbSNa8+NuPIh/4onuQcBRMchR8fp2xhVUnhnw8Pemc
 Dd3KYuQdPeBMOz5PAAdpP3ezBEfzhJ/tbKNb2OE8KWNUt+WIcwPKLaQzKtVyOB81Ur8D
 fUR99XpA+KlApF6wiF+vJPtKJ5DBiVUM7yPXXSEIIxru+PjEgen9lVufqxqfGHryyxTW
 3U/6C9Y1T3KAkW3ONPjcqpi2ReZNd679jm40HcINfFIfuSW2qaImZOqqkYMZ2xJ0qvXY
 5VCR0wHwoQiHSjl+pk55Og3B59ItaWEqOYsYqVZBdac/yNet4OXM7myaRSSoeM1Tlngi
 w8XA==
X-Gm-Message-State: ABy/qLZrU/DQx2b0lHB2D7CJCH1znUHZo1O0oo9NYvrYZswmj8unvGsY
 qdyJhjIbilgfTLMrpb3yXtSgr55qNceeqBzUAkQFrOfMb3I+a+7iKbqht++KP17bgth7SNEUcre
 carxh6fzbso5DwfQ=
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id
 s37-20020a05622a1aa500b0040c8ba533e0mr9210108qtc.3.1690823203996; 
 Mon, 31 Jul 2023 10:06:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFaHCr7QoFqmWO8YexCPiEQk23r9RFmadz74ZMk9Z1gcD/E9aECclmZWLkBKEeKmGChI5s7MA==
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id
 s37-20020a05622a1aa500b0040c8ba533e0mr9210088qtc.3.1690823203715; 
 Mon, 31 Jul 2023 10:06:43 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f2-20020ac840c2000000b00404f8e9902dsm1650019qtm.2.2023.07.31.10.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 10:06:43 -0700 (PDT)
Date: Mon, 31 Jul 2023 13:06:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/3] migration: Simplify calling of
 await_return_path_close_on_source
Message-ID: <ZMfqIb2c9tCxaNKy@x1n>
References: <20230728121516.16258-1-farosas@suse.de>
 <20230728121516.16258-3-farosas@suse.de> <ZMQ1ppAIJVbk8ZBg@x1n>
 <87leew8d70.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87leew8d70.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 31, 2023 at 09:42:27AM -0300, Fabiano Rosas wrote:
> They are made redundant by
> trace_await_return_path_close_on_source_joining() and
> trace_await_return_path_close_on_source_close() which already exist in
> the function.

Oh.. that's okay then.  Thanks,

-- 
Peter Xu


