Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50095B43818
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Sep 2025 12:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu6wI-0002D2-CZ; Thu, 04 Sep 2025 06:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu6w7-00022v-Vr; Thu, 04 Sep 2025 06:11:24 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uu6vz-00063I-62; Thu, 04 Sep 2025 06:11:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cHZs62mlRz6J6mF;
 Thu,  4 Sep 2025 18:07:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1542D1402F5;
 Thu,  4 Sep 2025 18:10:57 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Sep
 2025 12:10:56 +0200
Date: Thu, 4 Sep 2025 11:10:55 +0100
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
CC: Alistair Francis <alistair.francis@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, Jesper Devantier
 <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, <dlemoal@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v4 1/5] spdm-socket: add seperate send/recv functions
Message-ID: <20250904111055.000026a6@huawei.com>
In-Reply-To: <20250904031058.367667-3-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
 <20250904031058.367667-3-wilfred.opensource@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu,  4 Sep 2025 13:10:55 +1000
Wilfred Mallawa <wilfred.opensource@gmail.com> wrote:

> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> This is to support uni-directional transports such as SPDM over Storage.
> As specified by the DMTF DSP0286.
> 
> Also update spdm_socket_rsp() to use the new send()/receive() functions. For
> the case of spdm_socket_receive(), this allows us to do error checking
> in one place with the addition of spdm_socket_command_valid().
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Hi Wilfred,

Main comments are focused on patch break up and a few definitions that
are here but not used yet. Move those to the patch that first uses them.

Jonathan

> ---
>  backends/spdm-socket.c       | 56 +++++++++++++++++++++++++++++-------
>  include/system/spdm-socket.h | 35 ++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 11 deletions(-)
> 
> diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> index 2c709c68c8..3d264814df 100644
> --- a/backends/spdm-socket.c
> +++ b/backends/spdm-socket.c
> @@ -184,28 +184,62 @@ int spdm_socket_connect(uint16_t port, Error **errp)
>      return client_socket;
>  }
>  
> -uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
> -                         void *req, uint32_t req_len,
> -                         void *rsp, uint32_t rsp_len)
> +static bool spdm_socket_command_valid(uint32_t command)
As below - perhaps this sanity check belongs in a precursor patch?
> +{
> +    switch (command) {
> +    case SPDM_SOCKET_COMMAND_NORMAL:
> +    case SPDM_SOCKET_STORAGE_CMD_IF_SEND:
> +    case SPDM_SOCKET_STORAGE_CMD_IF_RECV:
> +    case SOCKET_SPDM_STORAGE_ACK_STATUS:
> +    case SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE:
> +    case SPDM_SOCKET_COMMAND_CONTINUE:
> +    case SPDM_SOCKET_COMMAND_SHUTDOWN:
> +    case SPDM_SOCKET_COMMAND_UNKOWN:
> +    case SPDM_SOCKET_COMMAND_TEST:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
> +uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
> +                             void *rsp, uint32_t rsp_len)
>  {
>      uint32_t command;
>      bool result;
>  
> -    result = send_platform_data(socket, transport_type,
> -                                SPDM_SOCKET_COMMAND_NORMAL,
> -                                req, req_len);
> -    if (!result) {
> +    result = receive_platform_data(socket, transport_type, &command,
> +                                   (uint8_t *)rsp, &rsp_len);
> +
> +    /* we may have received some data, but check if the command is valid */
> +    if (!result || !spdm_socket_command_valid(command)) {

Is this change related to the separate send/recv part?  Perhaps it
is a useful bit of hardening to do as a precursor patch?

>          return 0;
>      }
>  
> -    result = receive_platform_data(socket, transport_type, &command,
> -                                   (uint8_t *)rsp, &rsp_len);
> +    return rsp_len;
> +}
> +
> +bool spdm_socket_send(const int socket, uint32_t socket_cmd,
> +                      uint32_t transport_type, void *req, uint32_t req_len)
> +{
> +    return send_platform_data(socket, transport_type,
> +                              socket_cmd, req, req_len);

I'd wrap that closer to 80 chars.

> +}
> +
> +uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
> +                         void *req, uint32_t req_len,
> +                         void *rsp, uint32_t rsp_len)
> +{
> +    bool result;
> +
> +    result = spdm_socket_send(socket, SPDM_SOCKET_COMMAND_NORMAL,
> +                              transport_type, req, req_len);
>      if (!result) {
>          return 0;
>      }
>  
> -    assert(command != 0);
> -
> +    rsp_len = spdm_socket_receive(socket, transport_type, (uint8_t *)rsp,

Why casting to a uint8_t * ?  It is a void * and this function takes a void *.

> +                                  rsp_len);
>      return rsp_len;
>  }
>  
> diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
> index 5d8bd9aa4e..2b7d03f82d 100644
> --- a/include/system/spdm-socket.h
> +++ b/include/system/spdm-socket.h

>  /**
>   * spdm_socket_close: send a shutdown command to the server
>   * @socket: socket returned from spdm_socket_connect()
> @@ -60,6 +89,9 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
>  void spdm_socket_close(const int socket, uint32_t transport_type);
>  
>  #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
> +#define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
> +#define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
> +#define SOCKET_SPDM_STORAGE_ACK_STATUS            0x0004
>  #define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
>  #define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
>  #define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
> @@ -68,7 +100,10 @@ void spdm_socket_close(const int socket, uint32_t transport_type);
>  
>  #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
>  #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
> +#define SPDM_SOCKET_TRANSPORT_TYPE_SCSI           0x03
> +#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04

Not used in this patch. Move it to where it is first used.

>  
>  #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
> +#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02

Not used in this patch. 

>  
>  #endif


