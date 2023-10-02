Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5527B4E40
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEjB-0000gp-NQ; Mon, 02 Oct 2023 04:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foo00@h08.hostsharing.net>)
 id 1qnEj1-0000gK-BY; Mon, 02 Oct 2023 04:56:24 -0400
Received: from bmailout3.hostsharing.net ([2a01:4f8:150:2161:1:b009:f23e:0])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foo00@h08.hostsharing.net>)
 id 1qnEir-0003Hg-E4; Mon, 02 Oct 2023 04:56:19 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "*.hostsharing.net",
 Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
 by bmailout3.hostsharing.net (Postfix) with ESMTPS id 998B1101C08BA;
 Mon,  2 Oct 2023 10:47:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 68F1B2CFD2; Mon,  2 Oct 2023 10:47:53 +0200 (CEST)
Date: Mon, 2 Oct 2023 10:47:53 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: wilfred.mallawa@wdc.com, Jonathan.Cameron@Huawei.com,
 jiewen.yao@intel.com, qemu-devel@nongnu.org, kbusch@kernel.org,
 its@irrelevant.dk, mst@redhat.com, marcel.apfelbaum@gmail.com,
 hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
 qemu-block@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <20231002084753.GA23546@wunner.de>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915112723.2033330-3-alistair.francis@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: none client-ip=2a01:4f8:150:2161:1:b009:f23e:0;
 envelope-from=foo00@h08.hostsharing.net; helo=bmailout3.hostsharing.net
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 15, 2023 at 09:27:23PM +1000, Alistair Francis wrote:
> --- /dev/null
> +++ b/docs/specs/spdm.rst
> @@ -0,0 +1,56 @@
> +======================================================
> +QEMU Security Protocols and Data Models (SPDM) Support
> +======================================================
> +
> +SPDM enables authentication, attestation and key exchange to assist in
> +providing infrastructure security enablement. It's a standard published
> +by the DMTF https://www.dmtf.org/standards/SPDM.
> +
> +Setting up a SPDM server
[...]
> +    $ cd spdm-emu
> +    $ git submodule init; git submodule update --recursive
> +    $ mkdir build; cd build
> +    $ cmake -DARCH=x64 -DTOOLCHAIN=GCC -DTARGET=Debug -DCRYPTO=openssl ..
> +    $ make -j32
> +    $ make copy_sample_key # Build certificates, required for SPDM authentication.

Might be worth pointing out that certificates need to have a
Subject Alternative Name in compliance with PCIe r6.1 sec 6.31.3,
what to add to openssl.cnf to get one, e.g. ...

    subjectAltName = otherName:2.23.147;UTF8:Vendor=1b36:Device=0010:CC=010802:REV=02:SSVID=1af4:SSID=1100
    2.23.147 = ASN1:OID:2.23.147

... and how to regenerate certificates after modifying openssl.cnf, e.g. ...

    $ openssl req -nodes -newkey ec:param.pem -keyout end_responder.key -out end_responder.req -sha384 -batch -subj "/CN=DMTF libspdm ECP384 responder cert"
    $ openssl x509 -req -in end_responder.req -out end_responder.cert -CA inter.cert -CAkey inter.key -sha384 -days 3650 -set_serial 3 -extensions v3_end -extfile ../openssl.cnf
    $ openssl asn1parse -in end_responder.cert -out end_responder.cert.der
    $ cat ca.cert.der inter.cert.der end_responder.cert.der > bundle_responder.certchain.der

Or preferably modify upstream libspdm to automate this process,
make it less cumbersome and error-prone.


> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
> +{
> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
> +    void *rsp = doe_cap->read_mbox;
> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
> +    uint32_t recvd;

Might be worth mentioning somewhere that this only implements the
responder role.

CPUs are coming to market which contain a Trusted Security Module.
Some of those TSMs are capable of the SPDM requester role.  Should
qemu ever have the need to emulate a CPU containing a TSM, it may
become necessary to add SPDM requester support.

Thanks,

Lukas

