Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDBE74DD0C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 20:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIvF8-00030V-04; Mon, 10 Jul 2023 14:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qIvF4-00030I-Ob
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qIvF2-0004L8-9x
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689012246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=lINDu9zF1/xbUwdJTPzcSII+uWRPksrDZTrzUrschKo=;
 b=c4iZIFRDvbFQFAevYWADsL8fEoHdxn904os9RGkGVENlmip8vEM8cGLI/cM3xk/D1R/khW
 tMhpImz5mbZOJ3bFMINyW4Pj9W10j7VyhQZ+uup78ujITD7l8RgmbmT4bIpTazUUB2LkwI
 fAhQIbhwhO1BkntPZ3+uwQ3EBcD88dw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-IXkXL1qQOlmaOSFMZx4_cw-1; Mon, 10 Jul 2023 14:04:04 -0400
X-MC-Unique: IXkXL1qQOlmaOSFMZx4_cw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b8a7e21f15so74409745ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 11:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689012243; x=1691604243;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lINDu9zF1/xbUwdJTPzcSII+uWRPksrDZTrzUrschKo=;
 b=OL+R7gP0yOrFUt/9rUlCtiFIBIvDBCr+io+797HbwgGDTOzZ7VFUAbRDwXy6kwrsx8
 58PyCwMMtlG2D5tqWK/txwsinsQLk5SbrKJO149fRGIesyE+rTpU++hRIGatfQ6Aa+yS
 T4Is9dprxp+wsLG5QEsFU3JYf164VTcG5f3FD2IWIKPyGStpIC8RD2PPiYtyS6T7ewJH
 1rq0EfbTbGo0GdaJ2fZaKDcN2BhWexN5bwFVCqBk9HpBbqSmys4VluV3JBG3rKISnLm5
 +HxzP9cYr6waOJswRDcMcbYCOWbbGS9uGuUZLTL3V6Vniw94I5QMrcYXTj7p2dkFTsxw
 9BWA==
X-Gm-Message-State: ABy/qLbmWHk+4TVZXV5EFBPL2SOwOm3ZmaBsZSNlEonHcURKTT2EmOns
 GNp7M8JLS2UZryIfEDVF+3PtnFVd5Hfn6Jp1o9aKClgaKkUlTUICu687PNwyeDTRk1g72fPDP5A
 ffqEJ68KZOyfOC7hYJ2yavIvP66Yp2IgkCBvjo/jxsQ==
X-Received: by 2002:a17:902:ec86:b0:1af:e302:123 with SMTP id
 x6-20020a170902ec8600b001afe3020123mr20996598plg.3.1689012243150; 
 Mon, 10 Jul 2023 11:04:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFhleEyyIs4LR9x2prLlog2UOoUJUqWPV6eq5rFx7GdkwTl99dmIr8Ebgwjubn32YUPmV0PY1mjveFR+pZq5wo=
X-Received: by 2002:a17:902:ec86:b0:1af:e302:123 with SMTP id
 x6-20020a170902ec8600b001afe3020123mr20996568plg.3.1689012242705; Mon, 10 Jul
 2023 11:04:02 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Jul 2023 14:03:51 -0400
Message-ID: <CAFn=p-bgqcMWB3h0bEy2H9zC8sTV1UEov=i430sVaMLKoVQgEw@mail.gmail.com>
Subject: python qemu.qmp v0.0.3 released
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

Hi all, I've just published qemu.qmp v0.0.3 to PyPI.

PyPI: https://pypi.org/project/qemu.qmp/0.0.3/
readthedocs: https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/
changelog: https://qemu.readthedocs.io/projects/python-qemu-qmp/en/latest/main.html#changelog

Notably, this release drops support for Python 3.6 and modernizes the
python packaging infrastructure to be compatible with the forthcoming
Python 3.12 release expected this October. There is no impact to the
QEMU codebase at this time which is still using a wholly vendored
version of the library (that we dropped 3.6 support from earlier this
development cycle.)

Thanks,
--js


