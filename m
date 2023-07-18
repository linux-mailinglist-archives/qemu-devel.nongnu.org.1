Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2A1758639
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 22:44:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrWq-0004zE-In; Tue, 18 Jul 2023 16:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLrWl-0004yt-63
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 16:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLrWi-00067W-HS
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 16:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689712951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w92fyGOgerr//CCrC7f/lRakaoN6Qg+oLbP/YOwDzT4=;
 b=ZUTtSQnlFLKLG4xICC4MSobYoFMctNYvKiFFLog1m03AkRaELZRuXEmJXeSXBVcPFFdotp
 0ii107BKa/Lr97P0CmHRyLXESKGG7+pYvN76aPn0tGH6+XNl7wD6QQ8peUz/DH8nD9bDN7
 f0eqgEWezOaCDgvI061WI0cIs/XiDpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-lM8YMar8PQuqypcUWFnTcw-1; Tue, 18 Jul 2023 16:42:29 -0400
X-MC-Unique: lM8YMar8PQuqypcUWFnTcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58F47185A792;
 Tue, 18 Jul 2023 20:42:29 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F9E040C6CCC;
 Tue, 18 Jul 2023 20:42:05 +0000 (UTC)
Date: Tue, 18 Jul 2023 16:42:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 mst@redhat.com, philmd@linaro.org, thuth@redhat.com,
 Jeuk Kim <jeuk20.kim@samsung.com>
Subject: Re: [PATCH v4 2/3] hw/ufs: Support for Query Transfer Requests
Message-ID: <20230718204203.GP44841@fedora>
References: <cover.1688459061.git.jeuk20.kim@gmail.com>
 <f01e773fc73d56d48d9f0e2adac4d40209d3b223.1688459061.git.jeuk20.kim@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RUTCCw0YfeV0HZw+"
Content-Disposition: inline
In-Reply-To: <f01e773fc73d56d48d9f0e2adac4d40209d3b223.1688459061.git.jeuk20.kim@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--RUTCCw0YfeV0HZw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2023 at 05:33:58PM +0900, Jeuk Kim wrote:
> +static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
> +{
> +    UfsHc *u = req->hc;
> +    uint16_t prdt_len = le16_to_cpu(req->utrd.prd_table_length);
> +    uint16_t prdt_byte_off =
> +        le16_to_cpu(req->utrd.prd_table_offset) * sizeof(uint32_t);
> +    uint32_t prdt_size = prdt_len * sizeof(UfshcdSgEntry);
> +    g_autofree UfshcdSgEntry *prd_entries = NULL;
> +    hwaddr req_upiu_base_addr, prdt_base_addr;
> +    int err;
> +
> +    assert(!req->sg);
> +
> +    if (prdt_len == 0) {
> +        return MEMTX_OK;
> +    }
> +
> +    prd_entries = g_new(UfshcdSgEntry, prdt_size);
> +    if (!prd_entries) {

g_new() never returns NULL. The process aborts if there is not enough
memory available.

Use g_try_new() if you want to handle memory allocation failure.

> +        trace_ufs_err_memory_allocation();
> +        return MEMTX_ERROR;
> +    }
> +
> +    req_upiu_base_addr = ufs_get_req_upiu_base_addr(&req->utrd);
> +    prdt_base_addr = req_upiu_base_addr + prdt_byte_off;
> +
> +    err = ufs_addr_read(u, prdt_base_addr, prd_entries, prdt_size);
> +    if (err) {
> +        trace_ufs_err_dma_read_prdt(req->slot, prdt_base_addr);
> +        return err;
> +    }
> +
> +    req->sg = g_malloc0(sizeof(QEMUSGList));
> +    if (!req->sg) {

g_malloc0() never returns NULL. The process aborts if there is not
enough memory available.


--RUTCCw0YfeV0HZw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2+RsACgkQnKSrs4Gr
c8gd0Af+M4rzjJWxuHSxyUaJWGjKQsRGcKanTNtKjgHqgB5ie8XnNp6kqcOOJDT1
C8dK2T4VlUEnbRktFil/xF8HGJVOFPftd2XKC3k2Er/L9rs0qtdyegWVkuyuHU/q
M8tXJmbNYIjlRsbh7qRyZjU80fYBYL1+KMCUj2hfQ1GWmNRWf+tlo9dc/UocpSDH
H7qUTWTSza8HwvFKnS8nnqG1SEYoEsCg7GKBnoUYz7zCCD65+u0fT5PhQ0K5SUTX
RIYJOc2UlLDztWcEEWIzUUHruFE1fEHhnIquP7+RtIMDmAimGcpH3VxjXymNPI+L
5bpdiQ4Km/hh6IAsXLaYS8ycfb2FhA==
=hUJW
-----END PGP SIGNATURE-----

--RUTCCw0YfeV0HZw+--


