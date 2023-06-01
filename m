Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141107195C0
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:38:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dny-0001ng-RH; Thu, 01 Jun 2023 04:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4dnx-0001nU-N5
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4dnw-0003o4-2C
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685608627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llzAElU+/coIQeoN7wL9nawVE/68O7gV+uWIErknun0=;
 b=esvxoH60vPtgbIFF4bwgBOA5QFdWo7QA55NtsbnkyGjdTolZHdsUk58D2B61kP1Naw8Bn1
 efqRkXuSuSRCyaiKkGrAgL2cB46gIbdMoAYCZ4dUI9ci9BtPNaO/UaGWcIOA1FYcTaSCdz
 wlbFZhzTpIjgZf8gxDXGntRGwfGdCBI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-USG_RcDKNOSC-JcN7c_PZQ-1; Thu, 01 Jun 2023 04:37:01 -0400
X-MC-Unique: USG_RcDKNOSC-JcN7c_PZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63C7B801585;
 Thu,  1 Jun 2023 08:37:00 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEDAD140E962;
 Thu,  1 Jun 2023 08:36:57 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:36:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, eblake@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 sgarzare@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/6] block: add blk_io_plug_call() API
Message-ID: <ZHhYqDp5AUBBemcn@redhat.com>
References: <20230530180959.1108766-1-stefanha@redhat.com>
 <20230531195042.GA1509371@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VwdRIpMbxphm9SWD"
Content-Disposition: inline
In-Reply-To: <20230531195042.GA1509371@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--VwdRIpMbxphm9SWD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Am 31.05.2023 um 21:50 hat Stefan Hajnoczi geschrieben:
> Hi Kevin,
> Do you want to review the thread-local blk_io_plug() patch series or
> should I merge it?

I haven't reviewed it in detail, but on the high level it looks good to
me, and you already got reviews for the details.

Acked-by: Kevin Wolf <kwolf@redhat.com>

--VwdRIpMbxphm9SWD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmR4WKgACgkQfwmycsiP
L9bLuw/+JrEF/mSl3V9dn1UGqfl63d7JZc7Zt4RQ0VZa/Pto1DcA3itsLomClVXx
pzskkdFGt/GsSibCl642QP6fWYKvg5G8JVpelmR9qNHfpwjdyRhSmtTqgfkdONX7
UlyOmlQDEs7eSHYbz6lZPbTE0AVgGzncSxJmr4jyw71nR3qEvf3uilnt5542Z1KH
sDwHJat+LGEAebFW6H2DHskP5KfzohCvmB1ojAfZuRawdYEqEyxJPRyDwjl8kWbZ
yuq5SDvlYNPx3D1q03vnKWNoZztm/JQNiaEknTsOYLIM1Qa35RnKguZBglefTO48
NDKUBl7Ti9JgLB8kNqkS3rAHxF73U0lZJjYDE0zwZD83npI3VF5hvvdKbW0RKym5
XzDdVKu6YOTnjBmgDAk7p52yPXFopnx72u7B73XjTii8SZuiJkxi0hZYI44Z4Nkx
B0Dcf+2i1bWtCYW5qJMmpzpY3s+atj6MyGqrhcNLa4pDk0tcQl4rk8frnJHYRrfq
9Ge+4JGEpnb0lWB5OJTCVB1dsfC0StGcs3ahh21fd6XO2oogakibE9G+jUL+UEWZ
+X58VyDIhrXXXMS+CI6iiWp/LTMDTH2Bcy+RQ7Wb+nQ43m2mFCBLd+vYGvPt2xSS
cPFq7gxgfbLmzbLc4A71lljCn9NydX8sCpXClRQ5C8TzAzbUnX4=
=NFLD
-----END PGP SIGNATURE-----

--VwdRIpMbxphm9SWD--


